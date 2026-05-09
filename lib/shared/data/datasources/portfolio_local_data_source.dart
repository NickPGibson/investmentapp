import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
import 'package:investmentapp/features/assets/data/models/asset_model.dart';
import 'package:investmentapp/features/clients/data/models/client_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

abstract interface class PortfolioLocalDataSource {
  Future<void> initialise();
  Future<List<ClientModel>> getAllClients();
  Future<List<AssetModel>> getAllAssets();
  Future<Map<AssetModel, int>> getAssetsOfClient(String clientUuid);
  Future<Map<ClientModel, int>> getClientsOfAsset(String assetIsin);
}

class PortfolioLocalDataSourceImpl implements PortfolioLocalDataSource {
  late final Database _db;

  static const _clientsTable = 'clients';
  static const _assetsTable = 'assets';
  static const _holdingsTable = 'holdings';

  @override
  Future<void> initialise() async {
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    }
    _db = await openDatabase(
      join(await getDatabasesPath(), 'invest_database.db'),
      onOpen: (db) async {
        await _createTables(db);
      },
    );
  }

  Future<void> _createTables(Database db) async {
    await db.execute('DROP TABLE IF EXISTS $_clientsTable');
    await db.execute('DROP TABLE IF EXISTS $_assetsTable');
    await db.execute('DROP TABLE IF EXISTS $_holdingsTable');

    await db.execute('''
      CREATE TABLE clients(
        uuid TEXT PRIMARY KEY,
        name TEXT,
        portfolioValue TEXT,
        imageUri TEXT,
        risk_strategy TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE assets(
        isin TEXT PRIMARY KEY,
        name TEXT,
        imageUri TEXT,
        risk_rating TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE holdings(
        clientUuid TEXT,
        assetIsin TEXT,
        quantity INTEGER,
        PRIMARY KEY (clientUuid, assetIsin),
        FOREIGN KEY (clientUuid) REFERENCES clients(uuid),
        FOREIGN KEY (assetIsin) REFERENCES assets(isin)
      )
    ''');

    await db.execute('CREATE INDEX holdings_assetIsin_index ON holdings(assetIsin)');
    await db.execute('CREATE INDEX holdings_clientUuid_index ON holdings(clientUuid)');

    for (final client in _clients) {
      await db.insert(_clientsTable, client.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    for (final asset in _assets) {
      await db.insert(_assetsTable, asset.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    for (final holding in _holdings) {
      await db.insert(_holdingsTable, holding, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  @override
  Future<List<ClientModel>> getAllClients() async {
    final rows = await _db.query(_clientsTable);
    return rows.map(ClientModel.fromMap).toList();
  }

  @override
  Future<List<AssetModel>> getAllAssets() async {
    final rows = await _db.query(_assetsTable);
    return rows.map(AssetModel.fromMap).toList();
  }

  @override
  Future<Map<AssetModel, int>> getAssetsOfClient(String clientUuid) async {
    final results = await _db.rawQuery(
      'SELECT $_assetsTable.*, $_holdingsTable.quantity FROM $_holdingsTable '
      'INNER JOIN $_assetsTable ON $_holdingsTable.assetIsin = $_assetsTable.isin '
      'WHERE $_holdingsTable.clientUuid = ? ORDER BY $_holdingsTable.quantity DESC',
      [clientUuid],
    );
    return {for (final row in results) AssetModel.fromMap(row): row['quantity'] as int};
  }

  @override
  Future<Map<ClientModel, int>> getClientsOfAsset(String assetIsin) async {
    final results = await _db.rawQuery(
      'SELECT $_clientsTable.*, $_holdingsTable.quantity FROM $_holdingsTable '
      'INNER JOIN $_clientsTable ON $_holdingsTable.clientUuid = $_clientsTable.uuid '
      'WHERE $_holdingsTable.assetIsin = ? ORDER BY $_holdingsTable.quantity DESC',
      [assetIsin],
    );
    return {for (final row in results) ClientModel.fromMap(row): row['quantity'] as int};
  }

  final List<ClientModel> _clients = [
    ClientModel(uuid: '1', name: 'Mr Daniel Dreiberg', portfolioValue: Decimal.parse('110000'), imageUri: 'assets/images/DanielDreiberg.jpg', riskStrategy: 'Balanced'),
    ClientModel(uuid: '2', name: 'Ms Laurel Juspeczyk', portfolioValue: Decimal.parse('245000'), imageUri: 'assets/images/LaurelJuspeczyk.jpg', riskStrategy: 'Growth'),
    ClientModel(uuid: '3', name: 'Dr Jonathan Osterman', portfolioValue: Decimal.parse('65000'), imageUri: 'assets/images/JonathanOsterman.jpg', riskStrategy: 'Low'),
  ];

  final List<AssetModel> _assets = [
    AssetModel(isin: 'IE00B52L4369', name: 'BlackRock Institutional Cash Series Sterling Liquidity Agency Inc', imageUri: 'assets/images/blackrock.png', riskRating: 'Low'),
    AssetModel(isin: 'GB00BQ1YHQ70', name: 'Threadneedle UK Property Authorised Investment Net GBP 1 Acc', imageUri: 'assets/images/threadneedle.png', riskRating: 'Low'),
    AssetModel(isin: 'GB00BPN5P238', name: 'Vanguard US Equity Index Institutional Plus GBP Accumulation', imageUri: 'assets/images/vanguard.png', riskRating: 'Medium'),
    AssetModel(isin: 'GB00BG0QP828', name: 'Legal & General Japan Index Trust C Class Accumulation', imageUri: 'assets/images/legalandgeneral.png', riskRating: 'Medium'),
    AssetModel(isin: 'IE00B1S74Q32', name: 'Vanguard FTSE U.K. All Share Index Unit Trust Accumulation', imageUri: 'assets/images/vanguard.png', riskRating: 'Medium'),
  ];

  final List<Map<String, Object?>> _holdings = [
    {'clientUuid': '1', 'assetIsin': 'IE00B52L4369', 'quantity': 20},
    {'clientUuid': '1', 'assetIsin': 'GB00BQ1YHQ70', 'quantity': 20},
    {'clientUuid': '1', 'assetIsin': 'GB00BPN5P238', 'quantity': 60},
    {'clientUuid': '2', 'assetIsin': 'GB00BQ1YHQ70', 'quantity': 40},
    {'clientUuid': '2', 'assetIsin': 'GB00BG0QP828', 'quantity': 60},
    {'clientUuid': '3', 'assetIsin': 'IE00B1S74Q32', 'quantity': 10},
    {'clientUuid': '3', 'assetIsin': 'GB00BPN5P238', 'quantity': 10},
    {'clientUuid': '3', 'assetIsin': 'IE00B52L4369', 'quantity': 30},
    {'clientUuid': '3', 'assetIsin': 'GB00BQ1YHQ70', 'quantity': 30},
    {'clientUuid': '3', 'assetIsin': 'GB00BG0QP828', 'quantity': 20},
  ];
}

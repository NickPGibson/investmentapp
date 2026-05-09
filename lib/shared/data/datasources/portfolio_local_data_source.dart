import 'package:flutter/foundation.dart';
import 'package:investmentapp/features/assets/data/models/asset_model.dart';
import 'package:investmentapp/features/clients/data/models/client_model.dart';
import 'package:investmentapp/shared/data/datasources/seed_data_provider.dart';
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
  final SeedDataProvider _seedDataProvider;
  late final Database _db;

  static const _dbVersion = 1;
  static const _clientsTable = 'clients';
  static const _assetsTable = 'assets';
  static const _holdingsTable = 'holdings';

  PortfolioLocalDataSourceImpl(this._seedDataProvider);

  @override
  Future<void> initialise() async {
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    }
    _db = await openDatabase(
      join(await getDatabasesPath(), 'invest_database.db'),
      version: _dbVersion,
      onCreate: (db, version) => _createTablesAndSeed(db),
      onUpgrade: (db, oldVersion, newVersion) async {
        // Future schema migrations go here, keyed on oldVersion/newVersion.
      },
    );
  }

  Future<void> _createTablesAndSeed(Database db) async {
    await db.execute('''
      CREATE TABLE $_clientsTable(
        uuid TEXT PRIMARY KEY,
        name TEXT,
        portfolioValue TEXT,
        imageUri TEXT,
        risk_strategy TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE $_assetsTable(
        isin TEXT PRIMARY KEY,
        name TEXT,
        imageUri TEXT,
        risk_rating TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE $_holdingsTable(
        clientUuid TEXT,
        assetIsin TEXT,
        quantity INTEGER,
        PRIMARY KEY (clientUuid, assetIsin),
        FOREIGN KEY (clientUuid) REFERENCES $_clientsTable(uuid),
        FOREIGN KEY (assetIsin) REFERENCES $_assetsTable(isin)
      )
    ''');
    await db.execute('CREATE INDEX holdings_assetIsin_index ON $_holdingsTable(assetIsin)');
    await db.execute('CREATE INDEX holdings_clientUuid_index ON $_holdingsTable(clientUuid)');

    for (final client in _seedDataProvider.clients) {
      await db.insert(_clientsTable, client.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    for (final asset in _seedDataProvider.assets) {
      await db.insert(_assetsTable, asset.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    for (final holding in _seedDataProvider.holdings) {
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
}

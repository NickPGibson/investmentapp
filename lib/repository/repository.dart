

import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
import 'package:investmentapp/repository/models/asset.dart';
import 'package:investmentapp/repository/models/holding.dart';
import 'package:investmentapp/repository/models/client.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

interface class Repository {

  late final Database _db;

  static const _clientsTable = 'clients';
  static const _assetsTable = 'assets';
  static const _holdingsTable = 'holdings';

  Future<void> initialise() async {
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    }

    _db = await openDatabase(
      join(await getDatabasesPath(), 'invest_database.db'),
      onOpen: (db) async {
        await _createTables(db);
      }
    );
  }

  Future<void> _createTables(Database db) async {

    await db.execute("DROP TABLE IF EXISTS $_clientsTable");
    await db.execute("DROP TABLE IF EXISTS $_assetsTable");
    await db.execute("DROP TABLE IF EXISTS $_holdingsTable");

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

    await db.execute('''
      CREATE INDEX holdings_assetIsin_index ON holdings(assetIsin)
    ''');

    await db.execute('''
      CREATE INDEX holdings_clientUuid_index ON holdings(clientUuid)
    ''');

    for (var client in _clients) {
      await _insertClient(db, client);
    }
    for (var asset in _assets) {
      await _insertAsset(db, asset);
    }
    for (var holding in _holdings) {
      await _insertHolding(db, holding);
    }
  }

  Future<void> _insertClient(Database db, Client client) async {
    await db.insert(_clientsTable, client.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> _insertAsset(Database db, Asset asset) async {
    await db.insert(_assetsTable, asset.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> _insertHolding(Database db, Holding holding) async {
    await db.insert(_holdingsTable, holding.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Client>> getAllClients() async {
   final clients = await _db.query(_clientsTable);
   return clients.map(Client.fromMap).toList();
  }

  Future<List<Asset>> getAllAssets() async {
    final assets = await _db.query(_assetsTable);
    return assets.map(Asset.fromMap).toList();
  }

  Future<Map<Client, int>> getClientsOf({required String assetIsin}) async {
    final results = await _db.rawQuery("SELECT $_clientsTable.*, $_holdingsTable.quantity FROM $_holdingsTable INNER JOIN $_clientsTable ON $_holdingsTable.clientUuid = $_clientsTable.uuid WHERE $_holdingsTable.assetIsin = ? ORDER BY $_holdingsTable.quantity DESC", [assetIsin]);
    return { for (var row in results) Client.fromMap(row) : row['quantity'] as int };
  }

  Future<Map<Asset, int>> getAssetsOf({required String clientUuid}) async {
    final results = await _db.rawQuery("SELECT $_assetsTable.*, $_holdingsTable.quantity FROM $_holdingsTable INNER JOIN $_assetsTable ON $_holdingsTable.assetIsin = $_assetsTable.isin WHERE $_holdingsTable.clientUuid = ? ORDER BY $_holdingsTable.quantity DESC", [clientUuid]);
    return { for (var row in results) Asset.fromMap(row) : row['quantity'] as int };
  }


  final List<Client> _clients = [
    Client(uuid: "1", name: 'Mr Daniel Dreiberg', portfolioValue: Decimal.parse('110000'), imageUri: 'assets/images/DanielDreiberg.jpg', riskStrategy: 'Balanced'),
    Client(uuid: "2", name: 'Ms Laurel Juspeczyk', portfolioValue: Decimal.parse('245000'), imageUri: 'assets/images/LaurelJuspeczyk.jpg', riskStrategy: 'Growth'),
    Client(uuid: "3", name: 'Dr Jonathan Osterman', portfolioValue: Decimal.parse('65000'), imageUri: 'assets/images/JonathanOsterman.jpg', riskStrategy: 'Low'),
  ];

  final List<Asset> _assets = [
    Asset(isin: 'IE00B52L4369', name: "BlackRock Institutional Cash Series Sterling Liquidity Agency Inc", imageUri: 'assets/images/blackrock.png', riskRating: "Low"),
    Asset(isin: 'GB00BQ1YHQ70', name: "Threadneedle UK Property Authorised Investment Net GBP 1 Acc", imageUri: 'assets/images/threadneedle.png', riskRating: "Low"),
    Asset(isin: 'GB00BPN5P238', name: "Vanguard US Equity Index Institutional Plus GBP Accumulation", imageUri: 'assets/images/vanguard.png', riskRating: "Medium"),
    Asset(isin: 'GB00BG0QP828', name: "Legal & General Japan Index Trust C Class Accumulation", imageUri: 'assets/images/legalandgeneral.png', riskRating: "Medium"),
    Asset(isin: 'IE00B1S74Q32', name: "Vanguard FTSE U.K. All Share Index Unit Trust Accumulation", imageUri: 'assets/images/vanguard.png', riskRating: "Medium"),
  ];

  final List<Holding> _holdings = [
    Holding(clientUuid: '1', assetIsin: 'IE00B52L4369', quantity: 20),
    Holding(clientUuid: '1', assetIsin: 'GB00BQ1YHQ70', quantity: 20),
    Holding(clientUuid: '1', assetIsin: 'GB00BPN5P238', quantity: 60),

    Holding(clientUuid: '2', assetIsin: 'GB00BQ1YHQ70', quantity: 40),
    Holding(clientUuid: '2', assetIsin: 'GB00BG0QP828', quantity: 60),

    Holding(clientUuid: '3', assetIsin: 'IE00B1S74Q32', quantity: 10),
    Holding(clientUuid: '3', assetIsin: 'GB00BPN5P238', quantity: 10),
    Holding(clientUuid: '3', assetIsin: 'IE00B52L4369', quantity: 30),
    Holding(clientUuid: '3', assetIsin: 'GB00BQ1YHQ70', quantity: 30),
    Holding(clientUuid: '3', assetIsin: 'GB00BG0QP828', quantity: 20),
  ];
}

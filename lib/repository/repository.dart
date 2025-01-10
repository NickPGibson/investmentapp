

import 'package:decimal/decimal.dart';
import 'package:investmentapp/repository/models/asset.dart';
import 'package:investmentapp/repository/models/holding.dart';
import 'package:investmentapp/repository/models/client.dart';

class Repository {

  final List<Client> _clients = [
    Client(uuid: "1", name: 'Mr Daniel Dreiberg', portfolioValue: Decimal.parse('110000'), imageUri: 'assets/images/DanielDreiberg.jpg'),
    Client(uuid: "2", name: 'Ms Laurel Juspeczyk', portfolioValue: Decimal.parse('245000'), imageUri: 'assets/images/LaurelJuspeczyk.jpg'),
    Client(uuid: "3", name: 'Dr Jonathan Osterman', portfolioValue: Decimal.parse('65000'), imageUri: 'assets/images/JonathanOsterman.jpg'),
  ];

  final List<Asset> _assets = [
    Asset(isin: 'IE00B52L4369', name: "BlackRock Institutional Cash Series Sterling Liquidity Agency Inc", imageUri: 'assets/images/blackrock.png'),
    Asset(isin: 'GB00BQ1YHQ70', name: "Threadneedle UK Property Authorised Investment Net GBP 1 Acc", imageUri: 'assets/images/threadneedle.png'),
    Asset(isin: 'GB00BPN5P238', name: "Vanguard US Equity Index Institutional Plus GBP Accumulation", imageUri: 'assets/images/vanguard 2.png'),
    Asset(isin: 'GB00BG0QP828', name: "Legal & General Japan Index Trust C Class Accumulation", imageUri: 'assets/images/legalandgeneral.png'),
    Asset(isin: 'IE00B1S74Q32', name: "Vanguard FTSE U.K. All Share Index Unit Trust Accumulation", imageUri: 'assets/images/vanguard.png'),
  ];

  final List<Holding> _holdings = [
    Holding(clientUuid: '1', assetUuid: 'IE00B52L4369', quantity: 20),
    Holding(clientUuid: '1', assetUuid: 'GB00BQ1YHQ70', quantity: 20),
    Holding(clientUuid: '1', assetUuid: 'GB00BPN5P238', quantity: 60),
    Holding(clientUuid: '2', assetUuid: 'GB00BQ1YHQ70', quantity: 40),
    Holding(clientUuid: '2', assetUuid: 'GB00BG0QP828', quantity: 60),
    Holding(clientUuid: '3', assetUuid: 'IE00B1S74Q32', quantity: 10),
    Holding(clientUuid: '3', assetUuid: 'GB00BPN5P238', quantity: 10),
    Holding(clientUuid: '3', assetUuid: 'IE00B52L4369', quantity: 30),
    Holding(clientUuid: '3', assetUuid: 'GB00BQ1YHQ70', quantity: 30),
    Holding(clientUuid: '3', assetUuid: 'GB00BG0QP828', quantity: 20),
  ];


  Future<List<Client>> getAllClients() async {
    return _clients;
  }

  Future<List<Asset>> getAllAssets() async {
    return _assets;
  }
/*
  Future<List<Asset>> getPortfolio({required String clientId}) {

  }

  Future<Client> getClient({required String clientUuid}) async { // not needed?
    return _clients.firstWhere((element) => element.uuid == clientUuid);
  }

 */

  Future<Map<Client, int>> getClientsOf({required String assetUuid}) async {
    final assetHoldings = _holdings.where((element) => element.assetUuid == assetUuid);
    return { for (var holding in assetHoldings) _clients.firstWhere((element) => element.uuid == holding.clientUuid) : holding.quantity };
  }

  Future<Map<Asset, int>> getAssetsOf({required String clientUuid}) async {
    final clientHoldings = _holdings.where((element) => element.clientUuid == clientUuid);
    return { for (var holding in clientHoldings) _assets.firstWhere((element) => element.isin == holding.assetUuid) : holding.quantity };
  }
}

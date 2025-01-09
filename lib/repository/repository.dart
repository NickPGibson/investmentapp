

import 'package:decimal/decimal.dart';
import 'package:investmentapp/repository/models/asset.dart';
import 'package:investmentapp/repository/models/holding.dart';
import 'package:investmentapp/repository/models/client.dart';
import 'package:uuid/uuid.dart';

class Repository {

  final List<Client> _clients = [
    Client(uuid: "1", name: 'Mr Daniel Dreiberg', portfolioValue: Decimal.parse('110000')),
    Client(uuid: "2", name: 'Ms Laurel Juspeczyk', portfolioValue: Decimal.parse('245000')),
    Client(uuid: "3", name: 'Dr Jonathan Osterman', portfolioValue: Decimal.parse('65000')),
  ];

  final List<Asset> _assets = [
    Asset(assetIsin: 'IE00B52L4369', name: "BlackRock Institutional Cash Series Sterling Liquidity Agency Inc"),
    Asset(assetIsin: 'GB00BQ1YHQ70', name: "Threadneedle UK Property Authorised Investment Net GBP 1 Acc"),
    Asset(assetIsin: 'GB00BPN5P238', name: "Vanguard US Equity Index Institutional Plus GBP Accumulation"),
    Asset(assetIsin: 'GB00BG0QP828', name: "Legal & General Japan Index Trust C Class Accumulation"),
    Asset(assetIsin: 'IE00B1S74Q32', name: "Vanguard FTSE U.K. All Share Index Unit Trust Accumulation"),
    // todo add the rest
  ];

  final List<Holding> _holdings = [
    Holding(clientUuid: '1', assetUuid: 'IE00B52L4369', quantity: 20),
    Holding(clientUuid: '1', assetUuid: 'GB00BQ1YHQ70', quantity: 20),
    Holding(clientUuid: '1', assetUuid: 'GB00BPN5P238', quantity: 60),
    Holding(clientUuid: '2', assetUuid: 'GB00BQ1YHQ70', quantity: 40),
    Holding(clientUuid: '2', assetUuid: 'GB00BG0QP828', quantity: 60),
    Holding(clientUuid: '3', assetUuid: 'IE00B1S74Q32', quantity: 10),
    // todo add the rest
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
*/
  Future<Client> getClient({required String clientUuid}) async { // not needed?
    return _clients.firstWhere((element) => element.uuid == clientUuid);
  }

  Future<Map<Asset, int>> getAssetsOf({required String clientUuid}) async {
    final clientHoldings = _holdings.where((element) => element.clientUuid == clientUuid);
    return { for (var holding in clientHoldings) _assets.firstWhere((element) => element.assetIsin == holding.assetUuid) : holding.quantity };
  }
}

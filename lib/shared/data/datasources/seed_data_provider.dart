import 'package:decimal/decimal.dart';
import 'package:investmentapp/features/assets/data/models/asset_model.dart';
import 'package:investmentapp/features/clients/data/models/client_model.dart';

abstract interface class SeedDataProvider {
  List<ClientModel> get clients;
  List<AssetModel> get assets;
  List<Map<String, Object?>> get holdings;
}

class PortfolioSeedDataProvider implements SeedDataProvider {
  @override
  final List<ClientModel> clients = [
    ClientModel(uuid: '1', name: 'Mr Daniel Dreiberg', portfolioValue: Decimal.parse('110000'), imageUri: 'assets/images/DanielDreiberg.jpg', riskStrategy: 'Balanced'),
    ClientModel(uuid: '2', name: 'Ms Laurel Juspeczyk', portfolioValue: Decimal.parse('245000'), imageUri: 'assets/images/LaurelJuspeczyk.jpg', riskStrategy: 'Growth'),
    ClientModel(uuid: '3', name: 'Dr Jonathan Osterman', portfolioValue: Decimal.parse('65000'), imageUri: 'assets/images/JonathanOsterman.jpg', riskStrategy: 'Low'),
  ];

  @override
  final List<AssetModel> assets = [
    AssetModel(isin: 'IE00B52L4369', name: 'BlackRock Institutional Cash Series Sterling Liquidity Agency Inc', imageUri: 'assets/images/blackrock.png', riskRating: 'Low'),
    AssetModel(isin: 'GB00BQ1YHQ70', name: 'Threadneedle UK Property Authorised Investment Net GBP 1 Acc', imageUri: 'assets/images/threadneedle.png', riskRating: 'Low'),
    AssetModel(isin: 'GB00BPN5P238', name: 'Vanguard US Equity Index Institutional Plus GBP Accumulation', imageUri: 'assets/images/vanguard.png', riskRating: 'Medium'),
    AssetModel(isin: 'GB00BG0QP828', name: 'Legal & General Japan Index Trust C Class Accumulation', imageUri: 'assets/images/legalandgeneral.png', riskRating: 'Medium'),
    AssetModel(isin: 'IE00B1S74Q32', name: 'Vanguard FTSE U.K. All Share Index Unit Trust Accumulation', imageUri: 'assets/images/vanguard.png', riskRating: 'Medium'),
  ];

  @override
  final List<Map<String, Object?>> holdings = [
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

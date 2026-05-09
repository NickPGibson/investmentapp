import 'package:investmentapp/features/assets/domain/entities/asset.dart';
import 'package:investmentapp/features/clients/domain/entities/client.dart';

abstract interface class AssetRepository {
  Future<List<Asset>> getAllAssets();
  Future<Map<Client, int>> getClientsOfAsset(String assetIsin);
}

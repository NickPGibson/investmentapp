import 'package:investmentapp/features/assets/domain/repositories/asset_repository.dart';
import 'package:investmentapp/features/clients/domain/entities/client.dart';

class GetClientsOfAssetUseCase {
  final AssetRepository _repository;
  const GetClientsOfAssetUseCase(this._repository);

  Future<Map<Client, int>> call(String assetIsin) =>
      _repository.getClientsOfAsset(assetIsin);
}

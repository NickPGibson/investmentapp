import 'package:investmentapp/features/assets/domain/entities/asset.dart';
import 'package:investmentapp/features/assets/domain/repositories/asset_repository.dart';

class GetAllAssetsUseCase {
  final AssetRepository _repository;
  const GetAllAssetsUseCase(this._repository);

  Future<List<Asset>> call() => _repository.getAllAssets();
}

import 'package:investmentapp/features/assets/domain/entities/asset.dart';
import 'package:investmentapp/features/clients/domain/repositories/client_repository.dart';

class GetAssetsOfClientUseCase {
  final ClientRepository _repository;
  const GetAssetsOfClientUseCase(this._repository);

  Future<Map<Asset, int>> call(String clientUuid) =>
      _repository.getAssetsOfClient(clientUuid);
}

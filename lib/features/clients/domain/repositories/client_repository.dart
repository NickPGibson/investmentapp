import 'package:investmentapp/features/assets/domain/entities/asset.dart';
import 'package:investmentapp/features/clients/domain/entities/client.dart';

abstract interface class ClientRepository {
  Future<List<Client>> getAllClients();
  Future<Map<Asset, int>> getAssetsOfClient(String clientUuid);
}

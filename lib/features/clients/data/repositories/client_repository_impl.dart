import 'package:investmentapp/features/assets/domain/entities/asset.dart';
import 'package:investmentapp/features/clients/domain/entities/client.dart';
import 'package:investmentapp/features/clients/domain/repositories/client_repository.dart';
import 'package:investmentapp/shared/data/datasources/portfolio_local_data_source.dart';

class ClientRepositoryImpl implements ClientRepository {
  final PortfolioLocalDataSource _dataSource;
  const ClientRepositoryImpl(this._dataSource);

  @override
  Future<List<Client>> getAllClients() => _dataSource.getAllClients();

  @override
  Future<Map<Asset, int>> getAssetsOfClient(String clientUuid) =>
      _dataSource.getAssetsOfClient(clientUuid);
}

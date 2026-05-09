import 'package:investmentapp/features/assets/domain/entities/asset.dart';
import 'package:investmentapp/features/clients/domain/entities/client.dart';
import 'package:investmentapp/features/clients/domain/repositories/client_repository.dart';
import 'package:investmentapp/shared/data/datasources/portfolio_local_data_source.dart';
import 'package:investmentapp/shared/domain/portfolio_exception.dart';

class ClientRepositoryImpl implements ClientRepository {
  final PortfolioLocalDataSource _dataSource;
  const ClientRepositoryImpl(this._dataSource);

  @override
  Future<List<Client>> getAllClients() async {
    try {
      return await _dataSource.getAllClients();
    } catch (_) {
      throw const PortfolioException();
    }
  }

  @override
  Future<Map<Asset, int>> getAssetsOfClient(String clientUuid) async {
    try {
      return await _dataSource.getAssetsOfClient(clientUuid);
    } catch (_) {
      throw const PortfolioException();
    }
  }
}

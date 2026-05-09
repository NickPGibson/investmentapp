import 'package:investmentapp/features/assets/domain/entities/asset.dart';
import 'package:investmentapp/features/clients/domain/entities/client.dart';
import 'package:investmentapp/features/clients/domain/repositories/client_repository.dart';
import 'package:investmentapp/shared/data/datasources/portfolio_local_data_source.dart';
import 'package:investmentapp/shared/domain/portfolio_exception.dart';
import 'package:investmentapp/shared/services/logger.dart';

class ClientRepositoryImpl implements ClientRepository {
  final PortfolioLocalDataSource _dataSource;
  final Logger _logger;
  const ClientRepositoryImpl(this._dataSource, this._logger);

  @override
  Future<List<Client>> getAllClients() async {
    try {
      return await _dataSource.getAllClients();
    } on Exception catch (e, st) {
      _logger.error(e, st);
      throw PortfolioException(cause: e, stackTrace: st);
    }
  }

  @override
  Future<Map<Asset, int>> getAssetsOfClient(String clientUuid) async {
    try {
      return await _dataSource.getAssetsOfClient(clientUuid);
    } on Exception catch (e, st) {
      _logger.error(e, st);
      throw PortfolioException(cause: e, stackTrace: st);
    }
  }
}

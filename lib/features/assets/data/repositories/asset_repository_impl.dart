import 'package:investmentapp/features/assets/domain/entities/asset.dart';
import 'package:investmentapp/features/assets/domain/repositories/asset_repository.dart';
import 'package:investmentapp/features/clients/domain/entities/client.dart';
import 'package:investmentapp/shared/data/datasources/portfolio_local_data_source.dart';
import 'package:investmentapp/shared/domain/portfolio_exception.dart';
import 'package:investmentapp/shared/services/logger.dart';

class AssetRepositoryImpl implements AssetRepository {
  final PortfolioLocalDataSource _dataSource;
  final Logger _logger;
  const AssetRepositoryImpl(this._dataSource, this._logger);

  @override
  Future<List<Asset>> getAllAssets() async {
    try {
      return await _dataSource.getAllAssets();
    } on Exception catch (e, st) {
      _logger.error(e, st);
      throw PortfolioException(cause: e, stackTrace: st);
    }
  }

  @override
  Future<Map<Client, int>> getClientsOfAsset(String assetIsin) async {
    try {
      return await _dataSource.getClientsOfAsset(assetIsin);
    } on Exception catch (e, st) {
      _logger.error(e, st);
      throw PortfolioException(cause: e, stackTrace: st);
    }
  }
}

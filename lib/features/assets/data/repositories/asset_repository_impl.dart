import 'package:investmentapp/features/assets/domain/entities/asset.dart';
import 'package:investmentapp/features/assets/domain/repositories/asset_repository.dart';
import 'package:investmentapp/features/clients/domain/entities/client.dart';
import 'package:investmentapp/shared/data/datasources/portfolio_local_data_source.dart';

class AssetRepositoryImpl implements AssetRepository {
  final PortfolioLocalDataSource _dataSource;
  const AssetRepositoryImpl(this._dataSource);

  @override
  Future<List<Asset>> getAllAssets() => _dataSource.getAllAssets();

  @override
  Future<Map<Client, int>> getClientsOfAsset(String assetIsin) =>
      _dataSource.getClientsOfAsset(assetIsin);
}

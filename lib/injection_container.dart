import 'package:get_it/get_it.dart';
import 'package:investmentapp/features/assets/data/repositories/asset_repository_impl.dart';
import 'package:investmentapp/features/assets/domain/repositories/asset_repository.dart';
import 'package:investmentapp/features/assets/domain/usecases/get_all_assets_use_case.dart';
import 'package:investmentapp/features/assets/domain/usecases/get_clients_of_asset_use_case.dart';
import 'package:investmentapp/features/assets/presentation/bloc/asset_detail/asset_detail_bloc.dart';
import 'package:investmentapp/features/assets/presentation/bloc/assets/assets_bloc.dart';
import 'package:investmentapp/features/clients/data/repositories/client_repository_impl.dart';
import 'package:investmentapp/features/clients/domain/repositories/client_repository.dart';
import 'package:investmentapp/features/clients/domain/usecases/get_all_clients_use_case.dart';
import 'package:investmentapp/features/clients/domain/usecases/get_assets_of_client_use_case.dart';
import 'package:investmentapp/features/clients/presentation/bloc/client_detail/client_detail_bloc.dart';
import 'package:investmentapp/features/clients/presentation/bloc/clients/clients_bloc.dart';
import 'package:investmentapp/shared/data/datasources/portfolio_local_data_source.dart';
import 'package:investmentapp/shared/services/image_service.dart';
import 'package:investmentapp/shared/services/logger.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Infrastructure
  final dataSource = PortfolioLocalDataSourceImpl();
  await dataSource.initialise();
  sl.registerSingleton<PortfolioLocalDataSource>(dataSource);
  sl.registerLazySingleton<ImageService>(() => AssetImageService());
  sl.registerLazySingleton<Logger>(() => DebugLogger());

  // Repositories
  sl.registerLazySingleton<ClientRepository>(() => ClientRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<AssetRepository>(() => AssetRepositoryImpl(sl(), sl()));

  // Use cases
  sl.registerLazySingleton(() => GetAllClientsUseCase(sl()));
  sl.registerLazySingleton(() => GetAssetsOfClientUseCase(sl()));
  sl.registerLazySingleton(() => GetAllAssetsUseCase(sl()));
  sl.registerLazySingleton(() => GetClientsOfAssetUseCase(sl()));

  // BLoCs — factories for a fresh instance per navigation
  sl.registerFactory(() => ClientsBloc(sl()));
  sl.registerFactory(() => ClientDetailBloc(sl()));
  sl.registerFactory(() => AssetsBloc(sl()));
  sl.registerFactory(() => AssetDetailBloc(sl()));
}

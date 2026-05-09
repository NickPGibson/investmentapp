import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:investmentapp/features/assets/data/models/asset_model.dart';
import 'package:investmentapp/features/clients/data/models/client_model.dart';
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
import 'package:investmentapp/injection_container.dart';
import 'package:investmentapp/main.dart';
import 'package:investmentapp/shared/data/datasources/portfolio_local_data_source.dart';
import 'package:investmentapp/shared/services/image_service.dart';
import 'package:investmentapp/shared/services/logger.dart';
import 'package:mocktail/mocktail.dart';

class MockPortfolioLocalDataSource extends Mock implements PortfolioLocalDataSource {}

class MockLogger extends Mock implements Logger {}

void main() {
  final james = ClientModel(
    uuid: '1',
    name: 'James',
    portfolioValue: Decimal.parse('20000'),
    imageUri: 'assets/images/blackrock.png',
    riskStrategy: 'High',
  );
  final tom = ClientModel(
    uuid: '2',
    name: 'Tom',
    portfolioValue: Decimal.parse('30500'),
    imageUri: 'assets/images/blackrock.png',
    riskStrategy: 'Low',
  );
  const xyz = AssetModel(
    isin: 'XYZ',
    name: 'XYZ',
    imageUri: 'assets/images/blackrock.png',
    riskRating: 'Low',
  );
  const abc = AssetModel(
    isin: 'ABC',
    name: 'ABC',
    imageUri: 'assets/images/blackrock.png',
    riskRating: 'Medium',
  );

  setUp(() {
    sl.reset();
    final mockDataSource = MockPortfolioLocalDataSource();
    when(() => mockDataSource.getAllClients()).thenAnswer((_) async => [james, tom]);
    when(() => mockDataSource.getAllAssets()).thenAnswer((_) async => [xyz, abc]);
    when(() => mockDataSource.getAssetsOfClient('2')).thenAnswer((_) async => {xyz: 75, abc: 25});
    sl.registerSingleton<PortfolioLocalDataSource>(mockDataSource);
    sl.registerLazySingleton<ImageService>(() => AssetImageService());
    sl.registerLazySingleton<Logger>(() => MockLogger());
    sl.registerLazySingleton<ClientRepository>(() => ClientRepositoryImpl(sl(), sl()));
    sl.registerLazySingleton<AssetRepository>(() => AssetRepositoryImpl(sl(), sl()));
    sl.registerLazySingleton(() => GetAllClientsUseCase(sl()));
    sl.registerLazySingleton(() => GetAssetsOfClientUseCase(sl()));
    sl.registerLazySingleton(() => GetAllAssetsUseCase(sl()));
    sl.registerLazySingleton(() => GetClientsOfAssetUseCase(sl()));
    sl.registerFactory(() => ClientsBloc(sl()));
    sl.registerFactory(() => ClientDetailBloc(sl()));
    sl.registerFactory(() => AssetsBloc(sl()));
    sl.registerFactory(() => AssetDetailBloc(sl()));
  });

  testWidgets('Clients', (WidgetTester tester) async {
    await tester.pumpWidget(const InvestmentApp());
    await tester.pumpAndSettle();

    expect(find.text('James'), findsOneWidget);
    expect(find.text('£20,000'), findsOneWidget);

    expect(find.text('Tom'), findsOneWidget);
    expect(find.text('£30,500'), findsOneWidget);

    await tester.tap(find.text('Tom'));
    await tester.pumpAndSettle();

    expect(find.text('Risk Strategy: Low'), findsOneWidget);

    expect(find.text('XYZ'), findsOneWidget);
    expect(find.text('75%'), findsOneWidget);

    expect(find.text('ABC'), findsOneWidget);
    expect(find.text('25%'), findsOneWidget);
  });
}

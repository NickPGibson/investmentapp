import 'package:bloc_test/bloc_test.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:investmentapp/features/assets/domain/entities/asset.dart';
import 'package:investmentapp/features/assets/domain/usecases/get_all_assets_use_case.dart';
import 'package:investmentapp/features/assets/domain/usecases/get_clients_of_asset_use_case.dart';
import 'package:investmentapp/features/assets/presentation/bloc/asset_detail/asset_detail_bloc.dart';
import 'package:investmentapp/features/assets/presentation/bloc/assets/assets_bloc.dart';
import 'package:investmentapp/features/clients/domain/entities/client.dart';
import 'package:investmentapp/features/clients/domain/usecases/get_all_clients_use_case.dart';
import 'package:investmentapp/features/clients/domain/usecases/get_assets_of_client_use_case.dart';
import 'package:investmentapp/features/clients/presentation/bloc/client_detail/client_detail_bloc.dart';
import 'package:investmentapp/features/clients/presentation/bloc/clients/clients_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAllClientsUseCase extends Mock implements GetAllClientsUseCase {}

class MockGetAssetsOfClientUseCase extends Mock implements GetAssetsOfClientUseCase {}

class MockGetAllAssetsUseCase extends Mock implements GetAllAssetsUseCase {}

class MockGetClientsOfAssetUseCase extends Mock implements GetClientsOfAssetUseCase {}

void main() {
  group('BLoC tests', () {
    final mockGetAllClients = MockGetAllClientsUseCase();
    final mockGetAssetsOfClient = MockGetAssetsOfClientUseCase();
    final mockGetAllAssets = MockGetAllAssetsUseCase();
    final mockGetClientsOfAsset = MockGetClientsOfAssetUseCase();

    final james = Client(
      uuid: '1',
      name: 'James',
      portfolioValue: Decimal.parse('20000'),
      imageUri: 'assets/images/blackrock.png',
      riskStrategy: 'High',
    );
    final tom = Client(
      uuid: '2',
      name: 'Tom',
      portfolioValue: Decimal.parse('30500'),
      imageUri: 'assets/images/blackrock.png',
      riskStrategy: 'Low',
    );
    const xyz = Asset(
      isin: 'XYZ',
      name: 'XYZ',
      imageUri: 'assets/images/blackrock.png',
      riskRating: 'Low',
    );
    const abc = Asset(
      isin: 'ABC',
      name: 'ABC',
      imageUri: 'assets/images/blackrock.png',
      riskRating: 'Medium',
    );

    setUp(() {
      when(() => mockGetAllClients()).thenAnswer((_) async => [james, tom]);
      when(() => mockGetAssetsOfClient('2')).thenAnswer((_) async => {xyz: 75, abc: 25});
      when(() => mockGetAllAssets()).thenAnswer((_) async => [xyz, abc]);
      when(() => mockGetClientsOfAsset('2')).thenAnswer((_) async => {tom: 35});
    });

    blocTest(
      'ClientsBloc emits loading then loaded',
      build: () => ClientsBloc(mockGetAllClients),
      act: (bloc) => bloc.add(const ClientsFetchRequested()),
      expect: () => [
        const ClientsLoading(),
        ClientsLoaded([james, tom]),
      ],
      verify: (_) => verify(() => mockGetAllClients()).called(1),
    );

    blocTest(
      'ClientDetailBloc emits loading then loaded',
      build: () => ClientDetailBloc(mockGetAssetsOfClient),
      act: (bloc) => bloc.add(const ClientDetailFetchRequested('2')),
      expect: () => [
        const ClientDetailLoading(),
        ClientDetailLoaded({xyz: 75, abc: 25}),
      ],
      verify: (_) => verify(() => mockGetAssetsOfClient('2')).called(1),
    );

    blocTest(
      'AssetsBloc emits loading then loaded',
      build: () => AssetsBloc(mockGetAllAssets),
      act: (bloc) => bloc.add(const AssetsFetchRequested()),
      expect: () => [
        const AssetsLoading(),
        AssetsLoaded([xyz, abc]),
      ],
      verify: (_) => verify(() => mockGetAllAssets()).called(1),
    );

    blocTest(
      'AssetDetailBloc emits loading then loaded',
      build: () => AssetDetailBloc(mockGetClientsOfAsset),
      act: (bloc) => bloc.add(const AssetDetailFetchRequested('2')),
      expect: () => [
        const AssetDetailLoading(),
        AssetDetailLoaded({tom: 35}),
      ],
      verify: (_) => verify(() => mockGetClientsOfAsset('2')).called(1),
    );
  });
}

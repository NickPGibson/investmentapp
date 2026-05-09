import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:investmentapp/features/assets/domain/entities/asset.dart';
import 'package:investmentapp/features/assets/domain/repositories/asset_repository.dart';
import 'package:investmentapp/features/assets/domain/usecases/get_all_assets_use_case.dart';
import 'package:investmentapp/features/assets/domain/usecases/get_clients_of_asset_use_case.dart';
import 'package:investmentapp/features/clients/domain/entities/client.dart';
import 'package:investmentapp/features/clients/domain/repositories/client_repository.dart';
import 'package:investmentapp/features/clients/domain/usecases/get_all_clients_use_case.dart';
import 'package:investmentapp/features/clients/domain/usecases/get_assets_of_client_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockClientRepository extends Mock implements ClientRepository {}

class MockAssetRepository extends Mock implements AssetRepository {}

void main() {
  final mockClientRepo = MockClientRepository();
  final mockAssetRepo = MockAssetRepository();

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

  group('GetAllClientsUseCase', () {
    test('returns clients from repository', () async {
      when(() => mockClientRepo.getAllClients()).thenAnswer((_) async => [james, tom]);
      final useCase = GetAllClientsUseCase(mockClientRepo);

      final result = await useCase();

      expect(result, [james, tom]);
      verify(() => mockClientRepo.getAllClients()).called(1);
      verifyNever(() => mockClientRepo.getAssetsOfClient(any()));
    });
  });

  group('GetAssetsOfClientUseCase', () {
    test('returns assets for given client uuid', () async {
      when(() => mockClientRepo.getAssetsOfClient('2')).thenAnswer((_) async => {xyz: 75, abc: 25});
      final useCase = GetAssetsOfClientUseCase(mockClientRepo);

      final result = await useCase('2');

      expect(result, {xyz: 75, abc: 25});
      verify(() => mockClientRepo.getAssetsOfClient('2')).called(1);
      verifyNever(() => mockClientRepo.getAllClients());
    });
  });

  group('GetAllAssetsUseCase', () {
    test('returns assets from repository', () async {
      when(() => mockAssetRepo.getAllAssets()).thenAnswer((_) async => [xyz, abc]);
      final useCase = GetAllAssetsUseCase(mockAssetRepo);

      final result = await useCase();

      expect(result, [xyz, abc]);
      verify(() => mockAssetRepo.getAllAssets()).called(1);
      verifyNever(() => mockAssetRepo.getClientsOfAsset(any()));
    });
  });

  group('GetClientsOfAssetUseCase', () {
    test('returns clients for given asset isin', () async {
      when(() => mockAssetRepo.getClientsOfAsset('ABC')).thenAnswer((_) async => {tom: 35});
      final useCase = GetClientsOfAssetUseCase(mockAssetRepo);

      final result = await useCase('ABC');

      expect(result, {tom: 35});
      verify(() => mockAssetRepo.getClientsOfAsset('ABC')).called(1);
      verifyNever(() => mockAssetRepo.getAllAssets());
    });
  });
}

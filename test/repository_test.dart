import 'package:flutter_test/flutter_test.dart';
import 'package:investmentapp/features/assets/data/repositories/asset_repository_impl.dart';
import 'package:investmentapp/features/clients/data/repositories/client_repository_impl.dart';
import 'package:investmentapp/shared/data/datasources/portfolio_local_data_source.dart';
import 'package:investmentapp/shared/domain/portfolio_exception.dart';
import 'package:mocktail/mocktail.dart';

class MockPortfolioLocalDataSource extends Mock implements PortfolioLocalDataSource {}

void main() {
  late MockPortfolioLocalDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockPortfolioLocalDataSource();
  });

  group('ClientRepositoryImpl', () {
    late ClientRepositoryImpl repository;

    setUp(() {
      repository = ClientRepositoryImpl(mockDataSource);
    });

    test('getAllClients wraps data source error as PortfolioException', () {
      when(() => mockDataSource.getAllClients()).thenThrow(Exception('db error'));
      expect(repository.getAllClients(), throwsA(isA<PortfolioException>()));
    });

    test('getAssetsOfClient wraps data source error as PortfolioException', () {
      when(() => mockDataSource.getAssetsOfClient(any())).thenThrow(Exception('db error'));
      expect(repository.getAssetsOfClient('1'), throwsA(isA<PortfolioException>()));
    });
  });

  group('AssetRepositoryImpl', () {
    late AssetRepositoryImpl repository;

    setUp(() {
      repository = AssetRepositoryImpl(mockDataSource);
    });

    test('getAllAssets wraps data source error as PortfolioException', () {
      when(() => mockDataSource.getAllAssets()).thenThrow(Exception('db error'));
      expect(repository.getAllAssets(), throwsA(isA<PortfolioException>()));
    });

    test('getClientsOfAsset wraps data source error as PortfolioException', () {
      when(() => mockDataSource.getClientsOfAsset(any())).thenThrow(Exception('db error'));
      expect(repository.getClientsOfAsset('IE00B52L4369'), throwsA(isA<PortfolioException>()));
    });
  });
}

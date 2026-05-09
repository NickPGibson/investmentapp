import 'package:flutter_test/flutter_test.dart';
import 'package:investmentapp/features/assets/data/repositories/asset_repository_impl.dart';
import 'package:investmentapp/features/clients/data/repositories/client_repository_impl.dart';
import 'package:investmentapp/shared/data/datasources/portfolio_local_data_source.dart';
import 'package:investmentapp/shared/domain/portfolio_exception.dart';
import 'package:investmentapp/shared/services/logger.dart';
import 'package:mocktail/mocktail.dart';

class MockPortfolioLocalDataSource extends Mock implements PortfolioLocalDataSource {}

class MockLogger extends Mock implements Logger {}

void main() {
  late MockPortfolioLocalDataSource mockDataSource;
  late MockLogger mockLogger;

  final dbError = Exception('db error');

  setUpAll(() {
    registerFallbackValue(StackTrace.empty);
  });

  setUp(() {
    mockDataSource = MockPortfolioLocalDataSource();
    mockLogger = MockLogger();
  });

  Matcher wrapsDbError() => throwsA(
    isA<PortfolioException>().having((e) => e.cause, 'cause', dbError),
  );

  group('ClientRepositoryImpl', () {
    late ClientRepositoryImpl repository;

    setUp(() {
      repository = ClientRepositoryImpl(mockDataSource, mockLogger);
    });

    test('getAllClients wraps data source error and logs it', () async {
      when(() => mockDataSource.getAllClients()).thenThrow(dbError);
      await expectLater(repository.getAllClients(), wrapsDbError());
      verify(() => mockLogger.error(dbError, any())).called(1);
    });

    test('getAssetsOfClient wraps data source error and logs it', () async {
      when(() => mockDataSource.getAssetsOfClient(any())).thenThrow(dbError);
      await expectLater(repository.getAssetsOfClient('1'), wrapsDbError());
      verify(() => mockLogger.error(dbError, any())).called(1);
    });
  });

  group('AssetRepositoryImpl', () {
    late AssetRepositoryImpl repository;

    setUp(() {
      repository = AssetRepositoryImpl(mockDataSource, mockLogger);
    });

    test('getAllAssets wraps data source error and logs it', () async {
      when(() => mockDataSource.getAllAssets()).thenThrow(dbError);
      await expectLater(repository.getAllAssets(), wrapsDbError());
      verify(() => mockLogger.error(dbError, any())).called(1);
    });

    test('getClientsOfAsset wraps data source error and logs it', () async {
      when(() => mockDataSource.getClientsOfAsset(any())).thenThrow(dbError);
      await expectLater(repository.getClientsOfAsset('IE00B52L4369'), wrapsDbError());
      verify(() => mockLogger.error(dbError, any())).called(1);
    });
  });
}

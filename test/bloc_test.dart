


import 'package:bloc_test/bloc_test.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:investmentapp/pages/asset/asset_bloc.dart';
import 'package:investmentapp/pages/assets/assets_bloc.dart';
import 'package:investmentapp/pages/client/client_bloc.dart';
import 'package:investmentapp/pages/clients/clients_bloc.dart';
import 'package:investmentapp/repository/models/asset.dart';
import 'package:investmentapp/repository/models/client.dart';
import 'package:investmentapp/repository/repository.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements Repository {}

void main() {
  group('CounterBloc', () {

    final repository = MockRepository();

    setUp(() {

      when(() => repository.initialise()).thenAnswer((_) async {});

      when(() => repository.getAssetsOf(clientUuid: "2")).thenAnswer((_) async =>
      {
        Asset(
            isin: 'XYZ',
            name: "XYZ",
            imageUri: "assets/images/blackrock.png",
            riskRating: "Low"
        ) : 75,
        Asset(
            isin: 'ABC',
            name: "ABC",
            imageUri: "assets/images/blackrock.png",
            riskRating: "Medium"
        ) : 25,
      });

      when(() => repository.getAllAssets()).thenAnswer((_) async => [
        Asset(
            isin: 'XYZ',
            name: "XYZ",
            imageUri: "assets/images/blackrock.png",
            riskRating: "Low"
        ),
        Asset(
            isin: 'ABC',
            name: "ABC",
            imageUri: "assets/images/blackrock.png",
            riskRating: "Medium"
        )
      ]);

      when(() => repository.getClientsOf(assetIsin: "2")).thenAnswer((_) async => {
        Client(
          uuid: '2',
          name: "Tom",
          portfolioValue: Decimal.parse("30500"),
          imageUri: "assets/images/blackrock.png",
          riskStrategy: "Low",
        ): 35
      });

      when(() => repository.getAllClients()).thenAnswer((_) async => [
        Client(
          uuid: '1',
          name: "James",
          portfolioValue: Decimal.parse("20000"),
          imageUri: "assets/images/blackrock.png",
          riskStrategy: "High",
        ),
        Client(
          uuid: '2',
          name: "Tom",
          portfolioValue: Decimal.parse("30500"),
          imageUri: "assets/images/blackrock.png",
          riskStrategy: "Low",
        )
      ]);


    });


    blocTest(
      'AssetBloc',
      build: () => AssetBloc(repository),
      act: (bloc) {
        bloc.add(FetchClients("2"));
      },
      expect: () => [
        AssetLoading(),
        AssetLoaded({
          Client(
            uuid: '2',
            name: "Tom",
            portfolioValue: Decimal.parse("30500"),
            imageUri: "assets/images/blackrock.png",
            riskStrategy: "Low",
          ): 35
        })
      ],
      verify: (_) {
        verify(() => repository.getClientsOf(assetIsin: "2")).called(1);
      }
    );

    blocTest(
      'AssetsBloc',
      build: () => AssetsBloc(repository),
      act: (bloc) {
        bloc.add(FetchAllAssets());
      },
      expect: () => [
        AssetsLoading(),
        AssetsLoaded([
          Asset(
            isin: 'XYZ',
            name: "XYZ",
            imageUri: "assets/images/blackrock.png",
            riskRating: "Low"
          ),
          Asset(
            isin: 'ABC',
            name: "ABC",
            imageUri: "assets/images/blackrock.png",
            riskRating: "Medium"
           )]
        )
      ],
      verify: (_) {
        verify(() => repository.getAllAssets()).called(1);
      }
    );

    blocTest(
      'ClientBloc',
      build: () => ClientBloc(repository),
      act: (bloc) {
        bloc.add(FetchAssets(client: Client(
          uuid: '2',
          name: "Tom",
          portfolioValue: Decimal.parse("30500"),
          imageUri: "assets/images/blackrock.png",
          riskStrategy: "Low",
        )));
      },
      expect: () => [
        ClientLoading(),
        ClientReady(assets: {
          Asset(
              isin: 'XYZ',
              name: "XYZ",
              imageUri: "assets/images/blackrock.png",
              riskRating: "Low"
          ) : 75,
          Asset(
              isin: 'ABC',
              name: "ABC",
              imageUri: "assets/images/blackrock.png",
              riskRating: "Medium"
          ) : 25,
        })
      ],
      verify: (_) {
        verify(() => repository.getAssetsOf(clientUuid: "2")).called(1);
      }
    );

    blocTest(
      'ClientsBloc',
      build: () => ClientsBloc(repository),
      act: (bloc) {
        bloc.add(FetchAllClients());
      },
      expect: () => [
        ClientsLoading(),
        ClientsLoaded([
          Client(
            uuid: '1',
            name: "James",
            portfolioValue: Decimal.parse("20000"),
            imageUri: "assets/images/blackrock.png",
            riskStrategy: "High",
          ),
          Client(
            uuid: '2',
            name: "Tom",
            portfolioValue: Decimal.parse("30500"),
            imageUri: "assets/images/blackrock.png",
            riskStrategy: "Low",
          )
        ])
      ],
      verify: (_) {
        verify(() => repository.getAllClients()).called(1);
      }
    );
  });
}
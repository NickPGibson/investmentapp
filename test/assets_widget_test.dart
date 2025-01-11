
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:investmentapp/main.dart';
import 'package:investmentapp/repository/image_repository.dart';
import 'package:investmentapp/repository/models/asset.dart';
import 'package:investmentapp/repository/models/client.dart';
import 'package:investmentapp/repository/repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockRepository extends Mock implements Repository {}

void main() {

  testWidgets('Assets', (WidgetTester tester) async {

    final repository = MockRepository();

    when(() => repository.initialise()).thenAnswer((_) async {});

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

    when(() => repository.getClientsOf(assetIsin: "ABC")).thenAnswer((_) async => {
      Client(
        uuid: '2',
        name: "Tom",
        portfolioValue: Decimal.parse("30500"),
        imageUri: "assets/images/blackrock.png",
        riskStrategy: "Low",
      ): 35
    });


    await tester.pumpWidget(TestFrame(repository));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(ValueKey("AssetsKey")));
    await tester.pumpAndSettle();

    expect(find.text("XYZ"), findsOneWidget);
    expect(find.text("ABC"), findsOneWidget);

    await tester.tap(find.text("ABC"));
    await tester.pumpAndSettle();

    expect(find.text("Tom"), findsOneWidget);
    expect(find.text("Portfolio: 35%"), findsOneWidget);
    expect(find.text("James"), findsNothing);
  });
}

class TestFrame extends StatelessWidget {

  final Repository _repository;

  const TestFrame(this._repository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Repository>.value(
          value: _repository,
        ),
        Provider<ImageRepository>(
          create: (context) => ImageRepository(),
        ),
      ],
      child: InvestmentApp(),
    );
  }
}

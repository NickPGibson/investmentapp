import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:investmentapp/features/assets/domain/entities/asset.dart';
import 'package:investmentapp/features/clients/domain/entities/client.dart';

void main() {
  group('Client entity', () {
    final client = Client(
      uuid: '1',
      name: 'James',
      portfolioValue: Decimal.parse('20000'),
      imageUri: 'assets/images/blackrock.png',
      riskStrategy: 'High',
    );

    test('equal when all props match', () {
      final other = Client(
        uuid: '1',
        name: 'James',
        portfolioValue: Decimal.parse('20000'),
        imageUri: 'assets/images/blackrock.png',
        riskStrategy: 'High',
      );
      expect(client, equals(other));
      expect(client.hashCode, equals(other.hashCode));
    });

    test('not equal when uuid differs', () {
      final other = Client(
        uuid: '2',
        name: 'James',
        portfolioValue: Decimal.parse('20000'),
        imageUri: 'assets/images/blackrock.png',
        riskStrategy: 'High',
      );
      expect(client, isNot(equals(other)));
    });

    test('not equal when name differs', () {
      final other = Client(
        uuid: '1',
        name: 'Tom',
        portfolioValue: Decimal.parse('20000'),
        imageUri: 'assets/images/blackrock.png',
        riskStrategy: 'High',
      );
      expect(client, isNot(equals(other)));
    });

    test('not equal when portfolioValue differs', () {
      final other = Client(
        uuid: '1',
        name: 'James',
        portfolioValue: Decimal.parse('99999'),
        imageUri: 'assets/images/blackrock.png',
        riskStrategy: 'High',
      );
      expect(client, isNot(equals(other)));
    });

    test('not equal when riskStrategy differs', () {
      final other = Client(
        uuid: '1',
        name: 'James',
        portfolioValue: Decimal.parse('20000'),
        imageUri: 'assets/images/blackrock.png',
        riskStrategy: 'Low',
      );
      expect(client, isNot(equals(other)));
    });

    test('props contains all five fields', () {
      expect(client.props, hasLength(5));
      expect(client.props, containsAllInOrder([
        client.uuid,
        client.name,
        client.portfolioValue,
        client.imageUri,
        client.riskStrategy,
      ]));
    });
  });

  group('Asset entity', () {
    const asset = Asset(
      isin: 'XYZ',
      name: 'XYZ Fund',
      imageUri: 'assets/images/blackrock.png',
      riskRating: 'Low',
    );

    test('equal when all props match', () {
      const other = Asset(
        isin: 'XYZ',
        name: 'XYZ Fund',
        imageUri: 'assets/images/blackrock.png',
        riskRating: 'Low',
      );
      expect(asset, equals(other));
      expect(asset.hashCode, equals(other.hashCode));
    });

    test('not equal when isin differs', () {
      const other = Asset(
        isin: 'ABC',
        name: 'XYZ Fund',
        imageUri: 'assets/images/blackrock.png',
        riskRating: 'Low',
      );
      expect(asset, isNot(equals(other)));
    });

    test('not equal when riskRating differs', () {
      const other = Asset(
        isin: 'XYZ',
        name: 'XYZ Fund',
        imageUri: 'assets/images/blackrock.png',
        riskRating: 'High',
      );
      expect(asset, isNot(equals(other)));
    });

    test('props contains all four fields', () {
      expect(asset.props, hasLength(4));
      expect(asset.props, containsAllInOrder([
        asset.isin,
        asset.name,
        asset.imageUri,
        asset.riskRating,
      ]));
    });
  });
}

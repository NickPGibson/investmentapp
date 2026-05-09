import 'package:decimal/decimal.dart';
import 'package:investmentapp/features/clients/domain/entities/client.dart';

class ClientModel extends Client {
  const ClientModel({
    required super.uuid,
    required super.name,
    required super.portfolioValue,
    required super.imageUri,
    required super.riskStrategy,
  });

  Map<String, Object?> toMap() => {
    'uuid': uuid,
    'name': name,
    'portfolioValue': portfolioValue.toString(),
    'imageUri': imageUri,
    'risk_strategy': riskStrategy,
  };

  factory ClientModel.fromMap(Map<String, Object?> map) => ClientModel(
    uuid: map['uuid'] as String,
    name: map['name'] as String,
    portfolioValue: Decimal.parse(map['portfolioValue'] as String),
    imageUri: map['imageUri'] as String,
    riskStrategy: map['risk_strategy'] as String,
  );
}

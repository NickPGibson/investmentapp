
import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';

class Client extends Equatable {

  final String uuid;
  final String name;
  final Decimal portfolioValue;
  final String imageUri;
  final String riskStrategy;

  const Client({required this.uuid, required this.name, required this.portfolioValue, required this.imageUri, required this.riskStrategy});

  Map<String, Object> toMap() {
    return {
      'uuid': uuid,
      'name': name,
      'portfolioValue': portfolioValue.toString(),
      'imageUri': imageUri,
      'risk_strategy': riskStrategy
    };
  }

  Client.fromMap(Map<String, Object?> map) :
    uuid = map['uuid'] as String,
    name = map['name'] as String,
    portfolioValue = Decimal.parse(map['portfolioValue'] as String),
    imageUri = map['imageUri'] as String,
    riskStrategy = map['risk_strategy'] as String;

  @override
  List<Object?> get props => [uuid, name, portfolioValue, imageUri, riskStrategy];
}

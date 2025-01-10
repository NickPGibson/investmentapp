
import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';

class Client extends Equatable {

  final String uuid;
  final String name;
  final Decimal portfolioValue;
  final String imageUri;

  const Client({required this.uuid, required this.name, required this.portfolioValue, required this.imageUri,/*required this.portfolio*/});

  @override
  List<Object?> get props => [uuid, name, portfolioValue, imageUri];
}


import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:investmentapp/repository/models/portfolio.dart';

class Client extends Equatable {

  final String uuid;
  final String name;
  final Decimal portfolioValue;
  //final Portfolio portfolio;

  const Client({required this.uuid, required this.name, required this.portfolioValue/*required this.portfolio*/});

  @override
  List<Object?> get props => [uuid, name, portfolioValue];
}

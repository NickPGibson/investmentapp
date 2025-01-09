

import 'package:equatable/equatable.dart';

class Asset extends Equatable {
  final String assetIsin;
  final String name;

  const Asset({required this.assetIsin, required this.name});


  @override
  List<Object?> get props => [assetIsin, name];
}
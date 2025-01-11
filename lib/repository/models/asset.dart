

import 'package:equatable/equatable.dart';

class Asset extends Equatable {
  final String isin;
  final String name;
  final String imageUri;

  const Asset({required this.isin, required this.name, required this.imageUri});

  @override
  List<Object?> get props => [isin, name, imageUri];
}
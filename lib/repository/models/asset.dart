

import 'package:equatable/equatable.dart';

class Asset extends Equatable {
  final String isin;
  final String name;
  final String imageUri;

  const Asset({required this.isin, required this.name, required this.imageUri});

  Map<String, Object?> toMap() {
    return {
      'isin': isin,
      'name': name,
      'imageUri': imageUri,
    };
  }

  Asset.fromMap(Map<String, Object?> map) :
    isin = map['isin'] as String,
    name = map['name'] as String,
    imageUri = map['imageUri'] as String;

  @override
  List<Object?> get props => [isin, name, imageUri];
}
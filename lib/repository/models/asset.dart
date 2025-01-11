

import 'package:equatable/equatable.dart';

class Asset extends Equatable {
  final String isin;
  final String name;
  final String imageUri;
  final String riskRating;

  const Asset({required this.isin, required this.name, required this.imageUri, required this.riskRating});

  Map<String, Object?> toMap() {
    return {
      'isin': isin,
      'name': name,
      'imageUri': imageUri,
      "risk_rating": riskRating
    };
  }

  Asset.fromMap(Map<String, Object?> map) :
    isin = map['isin'] as String,
    name = map['name'] as String,
    imageUri = map['imageUri'] as String,
    riskRating = map['risk_rating'] as String;

  @override
  List<Object?> get props => [isin, name, imageUri, riskRating];
}
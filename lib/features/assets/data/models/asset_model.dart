import 'package:investmentapp/features/assets/domain/entities/asset.dart';

class AssetModel extends Asset {
  const AssetModel({
    required super.isin,
    required super.name,
    required super.imageUri,
    required super.riskRating,
  });

  Map<String, Object?> toMap() => {
    'isin': isin,
    'name': name,
    'imageUri': imageUri,
    'risk_rating': riskRating,
  };

  factory AssetModel.fromMap(Map<String, Object?> map) => AssetModel(
    isin: map['isin'] as String,
    name: map['name'] as String,
    imageUri: map['imageUri'] as String,
    riskRating: map['risk_rating'] as String,
  );
}

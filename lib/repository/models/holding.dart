

class Holding {
  final String assetIsin;
  final String clientUuid;
  final int quantity;

  Map<String, Object?> toMap() {
    return {
      'assetIsin': assetIsin,
      'clientUuid': clientUuid,
      'quantity': quantity,
    };
  }

  Holding({required this.assetIsin, required this.clientUuid, required this.quantity});
}


class ServiceAccountReceivedEntity {
  final int id;
  final double amount; // Using double for decimal in Dart
  final int marketId;
  final String marketName;
  final double totalAmount; // Using double for decimal in Dart
  final int staleBread;
  final int givenBread;

  const ServiceAccountReceivedEntity({
    required this.id,
    required this.amount,
    required this.marketId,
    required this.marketName,
    required this.totalAmount,
    required this.staleBread,
    required this.givenBread,
  });


}

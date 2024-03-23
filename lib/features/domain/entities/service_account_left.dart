

class ServiceAccountLeftEntity {
  final int marketId;
  final String marketName;
  final double totalAmount; // Using double for decimal in Dart
  final int staleBread;
  final int givenBread;


  const ServiceAccountLeftEntity({
    required this.marketId,
    required this.marketName,
    required this.totalAmount,
    required this.staleBread,
    required this.givenBread
  });


}

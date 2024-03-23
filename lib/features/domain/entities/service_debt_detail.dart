

class ServiceDebtDetailEntity{
  final int id;
  final int marketId;
  final DateTime date;
  final double amount; // Using double for decimal in Dart

  const ServiceDebtDetailEntity({
    required this.id,
    required this.marketId,
    required this.date,
    required this.amount,
  });

}

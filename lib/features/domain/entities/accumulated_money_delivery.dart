class AccumulatedMoneyDeliveryEntity {
  final int id;
  final DateTime deliveryDate;
  final double deliveredAmount;
  final double totalAccumulatedAmount;

  const AccumulatedMoneyDeliveryEntity({
    required this.id,
    required this.deliveryDate,
    required this.deliveredAmount,
    required this.totalAccumulatedAmount,
  });
}

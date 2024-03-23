

class ReceivedMoneyFromServiceEntity{
  final int id;
  final int userId;
  final double amount; // Using double for decimal in Dart
  final int serviceTypeId;
  final DateTime date;

  const ReceivedMoneyFromServiceEntity({
    required this.id,
    required this.userId,
    required this.amount,
    required this.serviceTypeId,
    required this.date,
  });


}

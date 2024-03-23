

class GivenProductToServiceEntity{
  final int id;
  final int userId;
  final int quantity;
  final DateTime date;
  final int serviceProductId;
  final int serviceTypeId;

  const GivenProductToServiceEntity({
    required this.id,
    required this.userId,
    required this.quantity,
    required this.date,
    required this.serviceProductId,
    required this.serviceTypeId,
  });


}

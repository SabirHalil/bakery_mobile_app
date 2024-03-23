
class ServiceStaleProductEntity {
  final int id;
  final int userId;
  final DateTime date;
  final int serviceTypeId;
  final int serviceProductId;
  final int quantity;

  const ServiceStaleProductEntity({
    required this.id,
    required this.userId,
    required this.date,
    required this.serviceTypeId,
    required this.serviceProductId,
    required this.quantity,
  });

}


class StaleProductAddedEntity {
  final int id;
  final int productId;
  final String productName;
  final int quantity;
  final DateTime date;

  const StaleProductAddedEntity({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.date,
  });

}

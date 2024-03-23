

class ExpenseEntity {
  final int id;
  final String detail;
  final DateTime date;
  final double amount; 
  final int userId;

  const ExpenseEntity({
    required this.id,
    required this.detail,
    required this.date,
    required this.amount,
    required this.userId,
  });

}

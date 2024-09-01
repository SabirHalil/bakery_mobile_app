import '../../domain/entities/accumulated_money.dart';

class AccumulatedMoneyModel extends AccumulatedMoneyEntity {
  const AccumulatedMoneyModel({
    required int id,
    required DateTime date,
    required double amount,
  }) : super(
          id: id,
          date: date,
          amount: amount,
        );

  factory AccumulatedMoneyModel.fromJson(Map<String, dynamic> json) {
    return AccumulatedMoneyModel(
      id: json['id'] ?? 0,
      date: DateTime.parse(json['date'] ?? ''),
      amount: (json['amount'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'amount': amount,
    };
  }

  factory AccumulatedMoneyModel.fromEntity(AccumulatedMoneyEntity entity) {
    return AccumulatedMoneyModel(
      id: entity.id,
      date: entity.date,
      amount: entity.amount,
    );
  }
}

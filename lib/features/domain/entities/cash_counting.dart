import 'package:equatable/equatable.dart';

class CashCountingEntity extends Equatable {
  final int id;
  final double totalMoney; // Using double for decimal in Dart
  final double remainedMoney; // Using double for decimal in Dart
  final double creditCard; // Using double for decimal in Dart
  final DateTime date;

  const CashCountingEntity({
    required this.id,
    required this.totalMoney,
    required this.remainedMoney,
    required this.creditCard,
    required this.date,
  });

  @override
  List<Object?> get props {
    return [id, totalMoney, remainedMoney, creditCard, date];
  }
}

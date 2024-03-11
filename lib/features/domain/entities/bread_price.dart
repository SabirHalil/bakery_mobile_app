import 'package:equatable/equatable.dart';

class BreadPriceEntity extends Equatable {
  final int id;
  final DateTime date;
  final double price;

  const BreadPriceEntity({
    required this.id,
    required this.date,
    required this.price,
  });

  @override
  List<Object?> get props => [id, date, price];
}

import 'package:equatable/equatable.dart';

class ProductProcessEntity extends Equatable {
  final int id;
  final String name;
  final int categoryId;
  final double price;
  final bool status;

  const ProductProcessEntity({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.price,
    required this.status,
  });

  @override
  List<Object?> get props => [id, name, categoryId, price, status];
}

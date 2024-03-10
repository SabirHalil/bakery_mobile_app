
import '../../domain/entities/product_process.dart';

class ProductProcessModel extends ProductProcessEntity {
  const ProductProcessModel({
    required int id,
    required String name,
    required int categoryId,
    required double price,
    required bool status,
  }) : super(
          id: id,
          name: name,
          categoryId: categoryId,
          price: price,
          status: status,
        );

  factory ProductProcessModel.fromJson(Map<String, dynamic> json) {
    return ProductProcessModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      categoryId: json['categoryId'] ?? 0,
      price: (json['price'] ?? 0.0).toDouble(),
      status: json['status'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'categoryId': categoryId,
      'price': price,
      'status': status,
    };
  }
}

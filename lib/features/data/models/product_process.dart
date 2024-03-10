
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

  factory ProductProcessModel.fromJson(Map<String, dynamic> map) {
    return ProductProcessModel(
      id: map["id"] ?? 0,
      name: map["name"] ?? "",
      categoryId: map["categoryId"] ?? 0,
      price: (map["price"] ?? 0.0).toDouble(),
      status: map["status"] ?? false,
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

  factory ProductProcessModel.fromEntity(ProductProcessEntity entity) {
    return ProductProcessModel(
      id: entity.id,
      name: entity.name,
      categoryId: entity.categoryId,
      price: entity.price,
      status: entity.status,
    );
  }
}
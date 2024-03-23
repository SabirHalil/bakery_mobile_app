
import '../../domain/entities/service_product.dart';

class ServiceProductModel extends ServiceProductEntity {
  const ServiceProductModel({
    required int id,
    required String name,
    required bool isActive,
  }) : super(
          id: id,
          name: name,
          isActive: isActive,
        );

  factory ServiceProductModel.fromJson(Map<String, dynamic> json) {
    return ServiceProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      isActive: json['isActive'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isActive': isActive,
    };
  }

  factory ServiceProductModel.fromEntity(ServiceProductEntity entity) {
    return ServiceProductModel(
      id: entity.id,
      name: entity.name,
      isActive: entity.isActive,
    );
  }
}

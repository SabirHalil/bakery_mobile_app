import '../../domain/entities/dough_product_process.dart';

class DoughProductProcessModel extends DoughProductProcessEntity {
  const DoughProductProcessModel({
    required int id,
    required double breadEquivalent,
    required String name,
    required bool status,
  }) : super(
          id: id,
          breadEquivalent: breadEquivalent,
          name: name,
          status: status,
        );

  factory DoughProductProcessModel.fromJson(Map<String, dynamic> map) {
    return DoughProductProcessModel(
      id: map["id"] ?? 0,
      breadEquivalent: (map["breadEquivalent"] ?? 0.0).toDouble(),
      name: map["name"] ?? "",
      status: map["status"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'breadEquivalent': breadEquivalent,
      'name': name,
      'status': status,
    };
  }

  factory DoughProductProcessModel.fromEntity(DoughProductProcessEntity entity) {
    return DoughProductProcessModel(
      id: entity.id,
      breadEquivalent: entity.breadEquivalent,
      name: entity.name,
      status: entity.status,
    );
  }
}
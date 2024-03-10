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

  factory DoughProductProcessModel.fromJson(Map<String, dynamic> json) {
    return DoughProductProcessModel(
      id: json['id'] ?? 0,
      breadEquivalent: (json['breadEquivalent'] ?? 0.0).toDouble(),
      name: json['name'] ?? '',
      status: json['status'] ?? false,
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
}

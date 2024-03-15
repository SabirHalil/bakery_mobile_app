
import '../../domain/entities/market.dart';

class MarketModel extends MarketEntity {
  const MarketModel({
    required int id,
    required String name,
    required bool isActive,
  }) : super(
          id: id,
          name: name,
          isActive: isActive,
        );

  factory MarketModel.fromJson(Map<String, dynamic> json) {
    return MarketModel(
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

  factory MarketModel.fromEntity(MarketEntity entity) {
    return MarketModel(
      id: entity.id,
      name: entity.name,
      isActive: entity.isActive,
    );
  }
}

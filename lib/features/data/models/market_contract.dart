
import '../../domain/entities/market_contract.dart';

class MarketContractModel extends MarketContractEntity {
  const MarketContractModel({
    required int id,
    required int serviceProductId,
    required double price,
    required int marketId,
    required bool isActive,
  }) : super(
          id: id,
          serviceProductId: serviceProductId,
          price: price,
          marketId: marketId,
          isActive: isActive,
        );

  factory MarketContractModel.fromJson(Map<String, dynamic> json) {
    return MarketContractModel(
      id: json['id'] ?? 0,
      serviceProductId: json['serviceProductId'] ?? 0,
      price: (json['price'] ?? 0.0).toDouble(),
      marketId: json['marketId'] ?? 0,
      isActive: json['isActive'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceProductId': serviceProductId,
      'price': price,
      'marketId': marketId,
      'isActive': isActive,
    };
  }

  factory MarketContractModel.fromEntity(MarketContractEntity entity) {
    return MarketContractModel(
      id: entity.id,
      serviceProductId: entity.serviceProductId,
      price: entity.price,
      marketId: entity.marketId,
      isActive: entity.isActive,
    );
  }
}

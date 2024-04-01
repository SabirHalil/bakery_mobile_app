import '../../domain/entities/market_contract.dart';

class MarketContractModel extends MarketContractEntity {
  MarketContractModel(
      {required super.id,
      required super.serviceProductId,
      required super.price,
      required super.marketId,
      required super.isActive,
      super.marketName});

  factory MarketContractModel.fromJson(Map<String, dynamic> json) {
    return MarketContractModel(
        id: json['id'] ?? 0,
        serviceProductId: json['serviceProductId'] ?? 0,
        price: (json['price'] ?? 0.0).toDouble(),
        marketId: json['marketId'] ?? 0,
        isActive: json['isActive'] ?? false,
        marketName: json['marketName'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceProductId': serviceProductId,
      'price': price,
      'marketId': marketId,
      'isActive': isActive,
      'marketName': marketName
    };
  }

  factory MarketContractModel.fromEntity(MarketContractEntity entity) {
    return MarketContractModel(
        id: entity.id,
        serviceProductId: entity.serviceProductId,
        price: entity.price,
        marketId: entity.marketId,
        isActive: entity.isActive,
        marketName: entity.marketName);
  }

  MarketContractModel copyWith({
    int? id,
    int? serviceProductId,
    double? price,
    int? marketId,
    bool? isActive,
    String? marketName,
  }) {
    return MarketContractModel(
      id: id ?? this.id,
      serviceProductId: serviceProductId ?? this.serviceProductId,
      price: price ?? this.price,
      marketId: marketId ?? this.marketId,
      isActive: isActive ?? this.isActive,
      marketName: marketName ?? this.marketName,
    );
  }
}

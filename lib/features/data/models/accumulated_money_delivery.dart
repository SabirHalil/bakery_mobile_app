import '../../domain/entities/accumulated_money_delivery.dart';

class AccumulatedMoneyDeliveryModel extends AccumulatedMoneyDeliveryEntity {
  AccumulatedMoneyDeliveryModel({
    required int id,
    required DateTime deliveryDate,
    required double deliveredAmount,
    required double totalAccumulatedAmount,
  }) : super(
          id: id,
          deliveryDate: deliveryDate,
          deliveredAmount: deliveredAmount,
          totalAccumulatedAmount: totalAccumulatedAmount,
        );

  factory AccumulatedMoneyDeliveryModel.fromJson(Map<String, dynamic> json) {
    return AccumulatedMoneyDeliveryModel(
      id: json['id'] ?? 0,
      deliveryDate: DateTime.parse(json['deliveryDate'] ?? ''),
      deliveredAmount: (json['deliveredAmount'] ?? 0.0).toDouble(),
      totalAccumulatedAmount:
          (json['totalAccumulatedAmount'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'deliveryDate': deliveryDate.toIso8601String(),
      'deliveredAmount': deliveredAmount,
      'totalAccumulatedAmount': totalAccumulatedAmount,
    };
  }

    factory AccumulatedMoneyDeliveryModel.fromEntity(AccumulatedMoneyDeliveryEntity entity) {
    return AccumulatedMoneyDeliveryModel(
      id: entity.id,
      deliveryDate: entity.deliveryDate,
      deliveredAmount: entity.deliveredAmount,
      totalAccumulatedAmount: entity.totalAccumulatedAmount
    );
  }

  AccumulatedMoneyDeliveryModel copyWith({
    int? id,
    DateTime? deliveryDate,
    double? deliveredAmount,
    double? totalAccumulatedAmount,
  }) {
    return AccumulatedMoneyDeliveryModel(
      id: id ?? this.id,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      deliveredAmount: deliveredAmount ?? this.deliveredAmount,
      totalAccumulatedAmount:
          totalAccumulatedAmount ?? this.totalAccumulatedAmount,
    );
  }
}

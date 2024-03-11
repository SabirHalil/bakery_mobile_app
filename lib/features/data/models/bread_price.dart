
import '../../domain/entities/bread_price.dart';

class BreadPriceModel extends BreadPriceEntity {
  const BreadPriceModel({
    required int id,
    required DateTime date,
    required double price,
  }) : super(
          id: id,
          date: date,
          price: price,
        );

  factory BreadPriceModel.fromJson(Map<String, dynamic> json) {
    return BreadPriceModel(
      id: json['id'] ?? 0,
      date: DateTime.parse(json['date']),
      price: (json['price'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'price': price,
    };
  }

  factory BreadPriceModel.fromEntity(BreadPriceEntity entity) {
    return BreadPriceModel(
      id: entity.id,
      date: entity.date,
      price: entity.price,
    );
  }
}

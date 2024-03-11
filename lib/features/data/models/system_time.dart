import '../../domain/entities/system_time.dart';

class SystemTimeModel extends SystemTimeEntity {
  const SystemTimeModel({
    required int id,
    required int openTime,
    required int closeTime,
  }) : super(
          id: id,
          openTime: openTime,
          closeTime: closeTime,
        );

  factory SystemTimeModel.fromJson(Map<String, dynamic> json) {
    return SystemTimeModel(
      id: json['id'] ?? 0,
      openTime: json['openTime'] ?? 0,
      closeTime: json['closeTime'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'openTime': openTime,
      'closeTime': closeTime,
    };
  }

  factory SystemTimeModel.fromEntity(SystemTimeEntity entity) {
    return SystemTimeModel(
      id: entity.id,
      openTime: entity.openTime,
      closeTime: entity.closeTime,
    );
  }
}

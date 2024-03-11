import 'package:equatable/equatable.dart';

class SystemTimeEntity extends Equatable {
  final int id;
  final int openTime;
  final int closeTime;

  const SystemTimeEntity({
    required this.id,
    required this.openTime,
    required this.closeTime,
  });

  @override
  List<Object?> get props => [id, openTime, closeTime];
}

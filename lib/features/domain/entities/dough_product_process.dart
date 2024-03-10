import 'package:equatable/equatable.dart';

class DoughProductProcessEntity extends Equatable {
  final int id;
  final double breadEquivalent;
  final String name;
  final bool status;

  const DoughProductProcessEntity({
    required this.id,
    required this.breadEquivalent,
    required this.name,
    required this.status,
  });

  @override
  List<Object?> get props => [id, breadEquivalent, name, status];
}

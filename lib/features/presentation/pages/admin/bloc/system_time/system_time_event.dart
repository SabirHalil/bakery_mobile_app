part of 'system_time_bloc.dart';

sealed class SystemTimeEvent  {}


final class GetSystemTimeRequested extends SystemTimeEvent {}

final class UpdateSystemTimeRequested extends SystemTimeEvent {
  SystemTimeModel product;
  UpdateSystemTimeRequested({required this.product});
}

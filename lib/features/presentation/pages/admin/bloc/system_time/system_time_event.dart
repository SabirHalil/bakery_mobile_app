part of 'system_time_bloc.dart';

sealed class SystemTimeEvent  {}


final class GetSystemTimeRequested extends SystemTimeEvent {}

final class UpdateSystemTimeRequested extends SystemTimeEvent {
  SystemTimeModel systemTime;
  UpdateSystemTimeRequested({required this.systemTime});
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  ServiceBloc() : super(ServiceInitial()) {
    on<ServiceEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

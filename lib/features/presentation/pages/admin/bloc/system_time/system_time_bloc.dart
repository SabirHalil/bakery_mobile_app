import 'package:bakery_app/features/domain/usecases/system_time_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../../data/models/system_time.dart';

part 'system_time_event.dart';
part 'system_time_state.dart';

class SystemTimeBloc extends Bloc<SystemTimeEvent, SystemTimeState> {
  final SystemTimeUseCase _systemTimeUseCase;
  SystemTimeBloc(this._systemTimeUseCase) : super(const SystemTimeLoading()) {
    on<GetSystemTimeRequested>(onGetSystemTimeRequested);
    on<UpdateSystemTimeRequested>(onUpdateSystemTimeRequested);
  }

    onGetSystemTimeRequested(GetSystemTimeRequested event,
      Emitter<SystemTimeState> emit) async {
    emit(const SystemTimeLoading());
    final dataState = await _systemTimeUseCase.getSystemTime();

    if (dataState is DataSuccess && dataState.data != null) {
      emit(SystemTimeSuccess(
          systemTime:
              dataState.data as SystemTimeModel));
    }

    if (dataState is DataFailed) {
      emit(SystemTimeFailure(error: dataState.error!));
    }
  }

   onUpdateSystemTimeRequested(UpdateSystemTimeRequested event,
      Emitter<SystemTimeState> emit) async {
    final state = this.state;
    if (state is SystemTimeSuccess) {
      final dataState =
          await _systemTimeUseCase.updateSystemTime(event.product);

      if (dataState is DataSuccess) {
        emit(SystemTimeSuccess(systemTime: event.product));
      }

      if (dataState is DataFailed) {
        emit(SystemTimeFailure(error: dataState.error!));
      }
    }
  }


}

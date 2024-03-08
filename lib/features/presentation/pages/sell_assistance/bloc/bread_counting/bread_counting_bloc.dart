import 'package:bakery_app/features/domain/usecases/bread_counting_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../../../core/utils/toast_message.dart';
import '../../../../../data/models/bread_counting.dart';

part 'bread_counting_event.dart';
part 'bread_counting_state.dart';

class BreadCountingBloc extends Bloc<BreadCountingEvent, BreadCountingState> {
  final BreadCountingUseCase _breadCountingUseCase;
  BreadCountingBloc(this._breadCountingUseCase) : super(const BreadCountingLoading()) { 
    on<BreadCountingGetListRequested>(onGetBreadCountingList);
    on<BreadCountingPostRequested>(onPostBreadCounting);
    on<BreadCountingUpdateRequested>(onUpdateBreadCounting);
    on<BreadCountingDeleteRequested>(onDeleteBreadCounting);
  }
  void onGetBreadCountingList(
      BreadCountingGetListRequested event,
      Emitter<BreadCountingState> emit) async {
    emit(const BreadCountingLoading());
    final dataState = await _breadCountingUseCase.getBreadCountingByDate(event.date);
    if (dataState is DataSuccess) {
      
      emit(BreadCountingSuccess(breadCounting:dataState.data != null?dataState.data as BreadCountingModel:null ));
    }

    if (dataState is DataFailed) {
      emit(BreadCountingFailure(error: dataState.error!));
    }
  }

  void onPostBreadCounting(
      BreadCountingPostRequested event,
      Emitter<BreadCountingState> emit) async {

    emit(const BreadCountingLoading());

    final dataState = await _breadCountingUseCase
        .addBreadCounting(event.breadCounting);

    if (dataState is DataSuccess) {
      emit(BreadCountingSuccess(
          breadCounting: event.breadCounting));
      showToastMessage('Ekmek sayımı başarıyla eklendi');
    }

    if (dataState is DataFailed) {
      emit(BreadCountingFailure(error: dataState.error!));
    }
  }

  void onUpdateBreadCounting(
      BreadCountingUpdateRequested event,
      Emitter<BreadCountingState> emit) async {
    emit(const BreadCountingLoading());
    final dataState = await _breadCountingUseCase.updateBreadCounting(event.breadCounting);

    if (dataState is DataSuccess) {
      emit(BreadCountingSuccess(
          breadCounting: event.breadCounting));
      showToastMessage('Ekmek sayımı başarıyla güncellendi');
    }

    if (dataState is DataFailed) {
      emit(BreadCountingFailure(error: dataState.error!));
    }
  }

  void onDeleteBreadCounting(BreadCountingDeleteRequested event,
      Emitter<BreadCountingState> emit) async {
    emit(const BreadCountingLoading());

    final dataState = await _breadCountingUseCase
        .deleteBreadCountingById(event.id);

    if (dataState is DataSuccess) {
      emit(const BreadCountingSuccess());
      showToastMessage('Ekmek sayımı başarıyla silindi');
    }

    if (dataState is DataFailed) {
      emit(BreadCountingFailure(error: dataState.error!));
    }
  }
}

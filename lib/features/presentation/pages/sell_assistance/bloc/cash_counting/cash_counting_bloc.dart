import 'package:bakery_app/features/domain/usecases/cash_counting_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../../../core/utils/toast_message.dart';
import '../../../../../data/models/cash_counting.dart';

part 'cash_counting_event.dart';
part 'cash_counting_state.dart';

class CashCountingBloc extends Bloc<CashCountingEvent, CashCountingState> {
  final CashCountingUseCase _cashCountingUseCase;
  CashCountingBloc(this._cashCountingUseCase) : super(const CashCountingLoading()) {
    on<CashCountingGetListRequested>(onGetCashCountingList);
    on<CashCountingPostRequested>(onPostCashCounting);
    on<CashCountingUpdateRequested>(onUpdateCashCounting);
    on<CashCountingDeleteRequested>(onDeleteCashCounting);
  }
void onGetCashCountingList(
      CashCountingGetListRequested event,
      Emitter<CashCountingState> emit) async {
    emit(const CashCountingLoading());
    final dataState = await _cashCountingUseCase.getCashCountingByDate(event.date);
    if (dataState is DataSuccess) {
      
      emit(CashCountingSuccess(cashCounting:dataState.data != null?dataState.data as CashCountingModel:null ));
    }

    if (dataState is DataFailed) {
      emit(CashCountingFailure(error: dataState.error!.message));
    }
  }

  void onPostCashCounting(
      CashCountingPostRequested event,
      Emitter<CashCountingState> emit) async {

    emit(const CashCountingLoading());

    final dataState = await _cashCountingUseCase
        .addCashCounting(event.cashCounting);

    if (dataState is DataSuccess) {
      emit(CashCountingSuccess(
          cashCounting: event.cashCounting));
      showToastMessage('Kasa sayımı başarıyla eklendi');
    }

    if (dataState is DataFailed) {
      emit(CashCountingFailure(error: dataState.error!.message));
    }
  }

  void onUpdateCashCounting(
      CashCountingUpdateRequested event,
      Emitter<CashCountingState> emit) async {
    emit(const CashCountingLoading());
    final dataState = await _cashCountingUseCase.updateCashCounting(event.cashCounting);

    if (dataState is DataSuccess) {
      emit(CashCountingSuccess(
          cashCounting: event.cashCounting));
      showToastMessage('Kasa sayımı başarıyla güncellendi');
    }

    if (dataState is DataFailed) {
      emit(CashCountingFailure(error: dataState.error!.message));
    }
  }

  void onDeleteCashCounting(CashCountingDeleteRequested event,
      Emitter<CashCountingState> emit) async {
    emit(const CashCountingLoading());

    final dataState = await _cashCountingUseCase
        .deleteCashCountingById(event.id);

    if (dataState is DataSuccess) {
      emit(const CashCountingSuccess());
      showToastMessage('Kasa sayımı başarıyla silindi');
    }

    if (dataState is DataFailed) {
      emit(CashCountingFailure(error: dataState.error!.message));
    }
  }
}


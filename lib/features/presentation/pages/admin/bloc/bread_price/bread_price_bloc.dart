import 'package:bakery_app/features/domain/usecases/bread_price_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../../data/models/bread_price.dart';

part 'bread_price_event.dart';
part 'bread_price_state.dart';

class BreadPriceBloc extends Bloc<BreadPriceEvent, BreadPriceState> {
  final BreadPriceUseCase _breadPriceUseCase;
  BreadPriceBloc(this._breadPriceUseCase) : super(const BreadPriceLoading()) {
    on<GetBreadPriceRequested>(onGetBreadPriceRequested);
    on<AddBreadPriceRequested>(onAddBreadPriceRequested);
    on<UpdateBreadPriceRequested>(onUpdateBreadPriceRequested);
  }
  onGetBreadPriceRequested(GetBreadPriceRequested event,
      Emitter<BreadPriceState> emit) async {
    emit(const BreadPriceLoading());
    final dataState = await _breadPriceUseCase.getAllBreadPrices();

    if (dataState is DataSuccess && dataState.data != null) {
      emit(BreadPriceSuccess(
          breadPriceList:
              dataState.data as List<BreadPriceModel>));
    }

    if (dataState is DataFailed) {
      emit(BreadPriceFailure(error: dataState.error!));
    }
  }

  onAddBreadPriceRequested(AddBreadPriceRequested event,
      Emitter<BreadPriceState> emit) async {
    emit(const BreadPriceLoading());
    final dataState =
        await _breadPriceUseCase.addBreadPrice(event.breadPrice);

    if (dataState is DataSuccess) {
      final dataState = await _breadPriceUseCase.getAllBreadPrices();

      if (dataState is DataSuccess && dataState.data != null) {
        emit(BreadPriceSuccess(
            breadPriceList:
                dataState.data as List<BreadPriceModel>));
      }

      if (dataState is DataFailed) {
        emit(BreadPriceFailure(error: dataState.error!));
      }
    }

    if (dataState is DataFailed) {
      emit(BreadPriceFailure(error: dataState.error!));
    }
  }

  onUpdateBreadPriceRequested(UpdateBreadPriceRequested event,
      Emitter<BreadPriceState> emit) async {
    final state = this.state;
    if (state is BreadPriceSuccess) {
      final dataState =
          await _breadPriceUseCase.updateBreadPrice(event.breadPrice);

      if (dataState is DataSuccess) {
        emit(BreadPriceSuccess(breadPriceList: [
          ...state.breadPriceList!.map((element) =>
              element.id == event.breadPrice.id ? event.breadPrice : element)
        ]));
      }

      if (dataState is DataFailed) {
        emit(BreadPriceFailure(error: dataState.error!));
      }
    }
  }
}

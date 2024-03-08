import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../../data/models/stale_bread.dart';
import '../../../../../data/models/stale_bread_to_add.dart';
import '../../../../../domain/usecases/stale_bread_usecase.dart';

part 'stale_bread_products_event.dart';
part 'stale_bread_products_state.dart';

class StaleBreadProductsBloc extends Bloc<StaleBreadProductsEvent, StaleBreadProductsState> {
    final StaleBreadUseCase _staleBreadUseCase;
  StaleBreadProductsBloc(this._staleBreadUseCase) : super(const StaleBreadProductsLoading()) {
    on<GetStaleBreadProductsRequested>(onGetStaleBread);
    on<PostStaleBreadProductsRequested>(onPostServiceStaleLeft);

  }

   void onGetStaleBread(GetStaleBreadProductsRequested event,
      Emitter<StaleBreadProductsState> emit) async {
    emit(const StaleBreadProductsLoading());
    final dataState =
        await _staleBreadUseCase.getBreadProductListByDate(event.date);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(StaleBreadProductsSuccess(
          staleBreadProductsList:
              dataState.data as List<StaleBreadModel>));
    }

    if (dataState is DataFailed) {
      emit(StaleBreadProductsFailure(error: dataState.error!));
    }
  }

  void onPostServiceStaleLeft(PostStaleBreadProductsRequested event,
      Emitter<StaleBreadProductsState> emit) async {
    final state = this.state;
    emit(const StaleBreadProductsLoading());
    final dataState = await _staleBreadUseCase.addStaleBread(
        StaleBreadToAddModel(
            id: 0,
            doughFactoryProductId: event.staleBreadModel.id,
            date: DateTime.now(),
            quantity: event.staleQuantity));

    if (dataState is DataSuccess) {
      emit(StaleBreadProductsSuccess(
          staleBreadProductsList: [...?state.staleBreadProductsList]
            ..remove(event.staleBreadModel)));
   
    }

    if (dataState is DataFailed) {
      emit(StaleBreadProductsFailure(error: dataState.error!));
    }
  }

}

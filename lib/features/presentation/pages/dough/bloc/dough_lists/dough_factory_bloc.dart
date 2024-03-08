

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/models/dough_list.dart';

import 'package:bakery_app/features/domain/usecases/dough_factory_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

part 'dough_factory_event.dart';
part 'dough_factory_state.dart';

class DoughFactoryBloc extends Bloc<DoughFactoryEvent, DoughFactoryState> {
  final DoughUseCase _doughUseCase;
  DoughFactoryBloc(this._doughUseCase) : super(const DoughFactoryLoading()) {
    on<DoughGetListsRequested>(onGetDoughLists);
  }

  void onGetDoughLists(
      DoughGetListsRequested event, Emitter<DoughFactoryState> emit) async {
    emit(const DoughFactoryLoading());
    final dataState = await _doughUseCase.getDoughListsByDate(event.dateTime);
    if (dataState is DataSuccess && dataState.data != null) {
      emit(DoughGetListsSuccess(doughLists:dataState.data as List<DoughListModel>));
    }

    if (dataState is DataFailed) {
      emit(DoughFactoryFailure(error:dataState.error!));
    }
  }

}

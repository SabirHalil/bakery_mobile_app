import 'package:bakery_app/features/data/models/stale_bread_to_add.dart';
import 'package:bakery_app/features/domain/usecases/stale_bread_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';


import '../../../../../../core/resources/data_state.dart';
import '../../../../../../core/utils/toast_message.dart';
import '../../../../../data/models/stale_bread_added.dart';


part 'stale_bread_event.dart';
part 'stale_bread_state.dart';

class StaleBreadBloc extends Bloc<StaleBreadEvent, StaleBreadState> {
  final StaleBreadUseCase _staleBreadUseCase;
  StaleBreadBloc(this._staleBreadUseCase) : super(const StaleBreadLoading()) {
   on<GetStaleBreadRequested>(onGetStaleBread);
   on<RemoveStaleBreadRequested>(onRemoveStaleBread);
   on<UpdateStaleBreadRequested>(onUpdateStaleBread);


  }
   
    void onGetStaleBread(GetStaleBreadRequested event,
      Emitter<StaleBreadState> emit) async {
    emit(const StaleBreadLoading());
    final dataState =
        await _staleBreadUseCase.getAddedStaleBreadListByDate(event.date);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(StaleBreadSuccess(
          staleBreadList:
              dataState.data as List<StaleBreadAddedModel>));
    }

    if (dataState is DataFailed) {
      emit(StaleBreadFailure(error: dataState.error!));
    }
  }

  void onRemoveStaleBread(RemoveStaleBreadRequested event,
      Emitter<StaleBreadState> emit) async {
    final state = this.state;
    emit(const StaleBreadLoading());

    final dataState = await _staleBreadUseCase
        .deleteStaleBread(event.staleBreadAddedModel.id);

    if (dataState is DataSuccess) {
 
      emit(StaleBreadSuccess(
          staleBreadList: [...?state.staleBreadList]
            ..remove(event.staleBreadAddedModel)));
    }

    if (dataState is DataFailed) {
      emit(StaleBreadFailure(error: dataState.error!));
    }
  }

  void onUpdateStaleBread(UpdateStaleBreadRequested event,
      Emitter<StaleBreadState> emit) async {
    final state = this.state;
    if (state is StaleBreadSuccess) {
      emit(const StaleBreadLoading());
      try {
        var staleBreadToAdd = StaleBreadToAddModel(
            id: event.staleBreadAddedModel.id,
            quantity: event.staleBreadAddedModel.quantity,
            doughFactoryProductId: event.staleBreadAddedModel.doughFactoryProductId,
            date: DateTime.now());
       
        final dataState = await _staleBreadUseCase
            .updateStaleBread(staleBreadToAdd);
        if (dataState is DataSuccess) {
          emit(StaleBreadSuccess(staleBreadList: [
            ...state.staleBreadList!.map((element) =>
                element.id == event.staleBreadAddedModel.id
                    ? event.staleBreadAddedModel
                    : element)
          ]));
        }

        if (dataState is DataFailed) {
          emit(StaleBreadFailure(error: dataState.error!));
        }
      } catch (e) {
        
        showToastMessage(e.toString());
      }
    }
  }

}

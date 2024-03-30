import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/resources/data_state.dart';
import '../../../../../domain/usecases/pdf_usecase.dart';

part 'pdf_event.dart';
part 'pdf_state.dart';

class PdfBloc extends Bloc<PdfEvent, PdfState> {
  final PdfUseCase _pdfUseCase;
  PdfBloc(this._pdfUseCase) : super(const PdfInitial()) {
    on<PdfGetEndOfTheDayRequested>(onGetEndOfTheDayPdfReport);
    on<PdfGetDoughFactoryRequested>(onGetDoughFactoryPdfReport);
    on<PdfGetPastaneRequested>(onGetPastanePdfReport);
    on<PdfGetServiceRequested>(onGetServicePdfReport);
  }

  onGetEndOfTheDayPdfReport(
      PdfGetEndOfTheDayRequested event, Emitter<PdfState> emit) async {
    emit(const PdfLoading());
    final dataState = await _pdfUseCase.getEndOfTheDayPdfReport(event.date);

    if (dataState is DataSuccess && dataState.data != null) {
  

      emit(PdfSuccess(
          fileName: "GunSonu_${getFromattedDate(event.date)}",
          pageTitle: event.pageTitle,
          byteList: dataState.data as Uint8List));
    }
    if (dataState is DataFailed) {
      emit(PdfFailure(error: dataState.error!.message));
    }
  }

  onGetDoughFactoryPdfReport(
      PdfGetDoughFactoryRequested event, Emitter<PdfState> emit) async {
    emit(const PdfLoading());
    final dataState = await _pdfUseCase.getPdfOfDoughFactoryByDate(event.date);

    if (dataState is DataSuccess && dataState.data != null) {
    
      emit(PdfSuccess(
          fileName: "Hamurhane_${getFromattedDate(event.date)}",
          pageTitle: event.pageTitle,
          byteList: dataState.data as Uint8List));
    }
    if (dataState is DataFailed) {
      emit(PdfFailure(error: dataState.error!.message));
    }
  }

  onGetPastanePdfReport(
      PdfGetPastaneRequested event, Emitter<PdfState> emit) async {
    emit(const PdfLoading());
    final dataState = await _pdfUseCase.getPdfOfPastaneByDate(event.date);

    if (dataState is DataSuccess && dataState.data != null) {
      
      emit(PdfSuccess(
          fileName: "Pastane_${getFromattedDate(event.date)}",
          pageTitle: event.pageTitle,
          byteList: dataState.data as Uint8List));
    }
    if (dataState is DataFailed) {
      emit(PdfFailure(error: dataState.error!.message));
    }
  }

  onGetServicePdfReport(
      PdfGetServiceRequested event, Emitter<PdfState> emit) async {
    emit(const PdfLoading());
    final dataState = await _pdfUseCase.getPdfOfServiceByDate(event.date);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(PdfSuccess(
          fileName: "Servis_${getFromattedDate(event.date)}",
          pageTitle: event.pageTitle,
          byteList: dataState.data as Uint8List));
    }
    if (dataState is DataFailed) {
      emit(PdfFailure(error: dataState.error!.message));
    }
  }


  
}

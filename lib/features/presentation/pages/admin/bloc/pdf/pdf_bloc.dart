import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/resources/data_state.dart';
import '../../../../../domain/usecases/pdf_usecase.dart';

part 'pdf_event.dart';
part 'pdf_state.dart';

class PdfBloc extends Bloc<PdfEvent, PdfState> {
  final PdfUseCase _pdfUseCase;
  PdfBloc(this._pdfUseCase) : super(const PdfLoading()) {
    on<PdfGetEndOfTheDayRequested>(onGetEndOfTheDayPdfReport);
    on<PdfGetDoughFactoryRequested>(onGetDoughFactoryPdfReport);

  }

  onGetEndOfTheDayPdfReport(
      PdfGetEndOfTheDayRequested event, Emitter<PdfState> emit) async {
    emit(const PdfLoading());
    final dataState = await _pdfUseCase.getEndOfTheDayPdfReport(event.date);

    if (dataState is DataSuccess && dataState.data != null) {
      File file = await createFileOfPdfUrl(dataState.data as Uint8List,
          "GunSonu_${getFromattedDate(event.date)}");
      emit(PdfSuccess(pdfPath: file.path, pageTitle: event.pageTitle));
    }
    if (dataState is DataFailed) {
      emit(PdfFailure(error: dataState.error));
    }
  }

  onGetDoughFactoryPdfReport(
      PdfGetDoughFactoryRequested event, Emitter<PdfState> emit) async {
    emit(const PdfLoading());
    final dataState = await _pdfUseCase.getPdfOfDoughFactoryByDate(event.date);

    if (dataState is DataSuccess && dataState.data != null) {
      File file = await createFileOfPdfUrl(dataState.data as Uint8List,
          "Hamurhane_${getFromattedDate(event.date)}");
      emit(PdfSuccess(pdfPath: file.path, pageTitle: event.pageTitle));
    }
    if (dataState is DataFailed) {
      emit(PdfFailure(error: dataState.error));
    }
  }

  Future<File> createFileOfPdfUrl(List<int> bytes, String fileName) async {
    try {
      var dir = await getApplicationDocumentsDirectory();

      File file = File("${dir.path}/$fileName.pdf");

      await file.writeAsBytes(bytes, flush: true);
      return file;
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }
  }
}

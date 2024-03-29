import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
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
      // File file = await createFileOfPdfUrl(dataState.data as Uint8List,"GunSonu_${getFromattedDate(event.date)}");
      File file = await createFileOfPdfUrl(dataState.data as Uint8List,
          "GunSonu_${getFromattedDate(event.date)}");

      emit(PdfSuccess(
          pdfPath: file.path,
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
      String path = await savePdfFile(
        dataState.data as Uint8List,
      );
      emit(PdfSuccess(
          pdfPath: path,
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
      File file = await createFileOfPdfUrl(dataState.data as Uint8List,
          "Pastane_${getFromattedDate(event.date)}");
      emit(PdfSuccess(
          pdfPath: file.path,
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
      File file = await createFileOfPdfUrl(dataState.data as Uint8List,
          "Servis_${getFromattedDate(event.date)}");
      emit(PdfSuccess(
          pdfPath: file.path,
          pageTitle: event.pageTitle,
          byteList: dataState.data as Uint8List));
    }
    if (dataState is DataFailed) {
      emit(PdfFailure(error: dataState.error!.message));
    }
  }

  Future<String> savePdfFile(Uint8List byteData) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.notoSansRegular();
    final String textContent = utf8.decode(utf8.encode(byteData.toString()));
    // final String textContent = utf8.decode(byteData);

    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text(textContent, style: pw.TextStyle(font: font)),
        );
      },
    ));

    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/example.pdf';
    final File file = File(path);
    // PDF dosyasını kaydetmek veya paylaşmak için
//final m =  await Printing.sharePdf(bytes: await pdf.save(), filename: 'created_document.pdf');
    await file.writeAsBytes(await pdf.save());
    var q = await Printing.sharePdf(
        bytes: await pdf.save(), filename: 'created_document.pdf');
    return path;
  }

  Future<File> createFileOfPdfUrl(List<int> bytes, String fileName) async {
    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$fileName.pdf");
      
      await file.writeAsBytes(bytes, flush: true);
      return file;
      //*****************new demo*/
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }
  }
}

part of 'pdf_bloc.dart';

sealed class PdfState {
  const PdfState();
}

final class PdfInitial extends PdfState {
  const PdfInitial();
}

final class PdfLoading extends PdfState {
  const PdfLoading();
}

final class PdfFailure extends PdfState {
  final String? error;
  const PdfFailure({this.error});
}

final class PdfSuccess extends PdfState {
  final String? fileName;
  final Uint8List? byteList;

  final String pageTitle;
  const PdfSuccess({this.fileName, required this.pageTitle, required this.byteList});
}

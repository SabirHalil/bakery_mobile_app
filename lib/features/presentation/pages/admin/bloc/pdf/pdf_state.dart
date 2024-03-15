part of 'pdf_bloc.dart';

sealed class PdfState extends Equatable {
  const PdfState();

  get pdfPath => null;
}

final class PdfLoading extends PdfState {
  const PdfLoading();

  @override
  List<Object?> get props => [];
}

final class PdfFailure extends PdfState {
  final DioException? error;
  const PdfFailure({this.error});

  @override
  List<Object?> get props => [error];
}

final class PdfSuccess extends PdfState {
  @override
  final String? pdfPath;
  
  final String pageTitle;
  const PdfSuccess({this.pdfPath, required this.pageTitle});

  @override
  List<Object?> get props => [pdfPath,pageTitle];
}

part of 'pdf_bloc.dart';

sealed class PdfEvent {}

final class PdfGetEndOfTheDayRequested extends PdfEvent {
  DateTime date;
  String pageTitle;
  PdfGetEndOfTheDayRequested({required this.date, required this.pageTitle});
}

final class PdfGetDoughFactoryRequested extends PdfEvent {
  DateTime date;
  String pageTitle;
  PdfGetDoughFactoryRequested({required this.date, required this.pageTitle});
}

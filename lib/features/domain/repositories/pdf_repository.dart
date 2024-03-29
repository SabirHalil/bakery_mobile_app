
import 'dart:typed_data';

import '../../../core/resources/data_state.dart';

abstract class PdfRepository{
Future<DataState<Uint8List?>>getEndOfTheDayPdfReport(DateTime date);
Future<DataState<Uint8List?>>getPdfOfDoughFactoryByDate(DateTime date);
Future<DataState<Uint8List?>>getPdfOfPastaneByDate(DateTime date);
Future<DataState<Uint8List?>>getPdfOfServiceByDate(DateTime date);
}
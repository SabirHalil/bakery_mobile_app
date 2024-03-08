import 'dart:typed_data';

import 'package:bakery_app/features/domain/repositories/pdf_repository.dart';

import '../../../core/resources/data_state.dart';

class PdfUseCase {
  final PdfRepository _pdfRepository;
  PdfUseCase(this._pdfRepository);
  Future<DataState<Uint8List?>> getEndOfTheDayPdfReport(DateTime date) async {
    return _pdfRepository.getEndOfTheDayPdfReport(date);
  }
}

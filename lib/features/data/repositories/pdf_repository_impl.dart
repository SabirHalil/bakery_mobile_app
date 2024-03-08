import 'dart:io';
import 'dart:typed_data';

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/data_sources/remote/pdf_service.dart';
import 'package:bakery_app/features/domain/repositories/pdf_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/utils/show_snake_bar.dart';

class PdfRepositoryImpl extends PdfRepository {
  final PdfService _pdfService;
  PdfRepositoryImpl(this._pdfService);
  @override
  Future<DataState<Uint8List?>> getEndOfTheDayPdfReport(DateTime date)async {
     try {
      final httpResponse = await _pdfService.getPdfServiceListByDateAndServiceType(date:date);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data!);
      } else {
        return DataFailed(
          DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              requestOptions: httpResponse.response.requestOptions),
        );
      }
    } catch (e) {
      showSnakeBar(e.toString(), null, null);
rethrow;
    }
  }
}

import 'package:dio/dio.dart';

class PdfService {
    Dio dio;
  PdfService(this.dio);

  Future<Response> getPdfEndOfDayAccountDetailByDate(DateTime date) async {
    return dio.get('/api/EndOfDayAccount/GetEndOfDayAccountDetailPdf', queryParameters: {'date': date});
  }

  Future<Response> getPdfOfDoughFactoryByDate(DateTime date) async {
    return dio.get('/api/CreatePdf/CreatePdfOfHamurhane', queryParameters: {'date': date});
  }

  Future<Response> getPdfOfPastaneByDate(DateTime date) async {
    return dio.get('/api/CreatePdf/CreatePdfOfPastane', queryParameters: {'date': date});
  }

  Future<Response> getPdfOfServiceByDate(DateTime date) async {
    return dio.get('/api/CreatePdf/CreatePdfForMarketService', queryParameters: {'date': date});
  }
}

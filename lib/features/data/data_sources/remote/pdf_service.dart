import 'package:dio/dio.dart';

class PdfService {
  Dio dio;
  PdfService(this.dio);

  Future<Response> getPdfEndOfDayAccountDetailByDate(DateTime date) async {
    return dio.get(
      '/api/EndOfDayAccount/GetEndOfDayAccountDetailPdf',
      queryParameters: {'date': date},
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );
  }

  Future<Response> getPdfOfDoughFactoryByDate(DateTime date) async {
    return dio.get(
      '/api/CreatePdf/CreatePdfForHamurhane',
      queryParameters: {'date': date},
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );
  }

  Future<Response> getPdfOfPastaneByDate(DateTime date) async {
    return dio.get(
      '/api/CreatePdf/CreatePdf',
      queryParameters: {'date': date},
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );
  }

  Future<Response> getPdfOfServiceByDate(DateTime date) async {
    return dio.get(
      '/api/CreatePdf/CreatePdfForMarketService',
      queryParameters: {'date': date},
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );
  }
}

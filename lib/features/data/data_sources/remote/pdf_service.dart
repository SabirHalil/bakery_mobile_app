import 'dart:typed_data';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';
part 'pdf_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class PdfService {
  factory PdfService(Dio dio, String baseUrl) =_PdfService;
  @GET("/api/EndOfDayAccount/GetEndOfDayAccountDetailPdf")
  Future<HttpResponse<Uint8List?>>getPdfEndOfDayAccountDetailByDate(@Query("date") DateTime date,);
  @GET("/api/CreatePdf/CreatePdfOfHamurhane")
  Future<HttpResponse<Uint8List?>>getPdfOfDoughFactoryByDate(@Query("date") DateTime date,);
  @GET("/api/CreatePdf/CreatePdfOfPastane")
  Future<HttpResponse<Uint8List?>>getPdfOfPastaneByDate(@Query("date") DateTime date,);
  @GET("/api/CreatePdf/CreatePdfForMarketService")
  Future<HttpResponse<Uint8List?>>getPdfOfServiceByDate(@Query("date") DateTime date,);
}

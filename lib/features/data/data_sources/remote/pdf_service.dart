import 'dart:typed_data';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';
part 'pdf_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class PdfService {
  factory PdfService(Dio dio, String baseUrl) =_PdfService;
  @GET("/api/EndOfDayAccount/GetGivenProductsToServiceByDateAndServisTypeId")
  Future<HttpResponse<Uint8List?>>
      getPdfServiceListByDateAndServiceType(
          {@Query("date") DateTime date,});
}

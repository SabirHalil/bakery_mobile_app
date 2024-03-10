// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _PdfService implements PdfService {
  _PdfService(
    this._dio, 
    this.baseUrl,
  ) {
    baseUrl ??= 'http://93.190.8.250:6500';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResponse<Uint8List?>> getPdfServiceListByDateAndServiceType(
      DateTime date) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'date': date.toIso8601String()};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Uint8List?>(
        _setStreamType<HttpResponse<Uint8List>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/EndOfDayAccount/GetGivenProductsToServiceByDateAndServisTypeId',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value =
        _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<Uint8List?>> getPdfOfDoughFactoryByDate(
      DateTime date) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'date': date.toIso8601String()};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Uint8List?>(
        _setStreamType<HttpResponse<Uint8List>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/CreatePdf/CreatePdfForHamurhane',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value =
        _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}

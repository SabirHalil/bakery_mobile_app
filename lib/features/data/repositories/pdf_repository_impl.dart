import 'dart:io';
import 'dart:typed_data';

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/data_sources/remote/pdf_service.dart';
import 'package:bakery_app/features/domain/repositories/pdf_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/error/failures.dart';

class PdfRepositoryImpl extends PdfRepository {
  final PdfService _pdfService;
  PdfRepositoryImpl(this._pdfService);
  @override
  Future<DataState<Uint8List?>> getEndOfTheDayPdfReport(DateTime date) async {
    try {
      final httpResponse =
          await _pdfService.getPdfEndOfDayAccountDetailByDate(date);
      if (httpResponse.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data!);
      } else {
        return DataFailed(
          Failure(httpResponse.statusMessage!),
        );
      }
    } on DioException catch (e) {
        return DataFailed(Failure(e.response?.data ?? e.message)); 
    } catch (e) {
      return DataFailed(Failure(e.toString()));
    }
  }

  @override
  Future<DataState<Uint8List?>> getPdfOfDoughFactoryByDate(
      DateTime date) async {
    try {
      final httpResponse = await _pdfService.getPdfOfDoughFactoryByDate(date);
      if (httpResponse.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data!);
      } else {
        return DataFailed(
          Failure(httpResponse.statusMessage!),
        );
      }
    } on DioException catch (e) {
       return DataFailed(Failure(e.response?.data ?? e.message)); 
    } catch (e) {
      return DataFailed(Failure(e.toString()));
    }
  }

  @override
  Future<DataState<Uint8List?>> getPdfOfPastaneByDate(DateTime date) async {
    try {
      final httpResponse = await _pdfService.getPdfOfPastaneByDate(date);
      if (httpResponse.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data!);
      } else {
        return DataFailed(
          Failure(httpResponse.statusMessage!),
        );
      }
    } on DioException catch (e) {
       return DataFailed(Failure(e.response?.data ?? e.message)); 
    } catch (e) {
      return DataFailed(Failure(e.toString()));
    }
  }

  @override
  Future<DataState<Uint8List?>> getPdfOfServiceByDate(DateTime date) async {
    try {
      final httpResponse = await _pdfService.getPdfOfServiceByDate(date);
      if (httpResponse.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data!);
      } else {
        return DataFailed(
          Failure(httpResponse.statusMessage!),
        );
      }
    } on DioException catch (e) {
       return DataFailed(Failure(e.response?.data ?? e.message)); 
    } catch (e) {
      return DataFailed(Failure(e.toString()));
    }
  }
}

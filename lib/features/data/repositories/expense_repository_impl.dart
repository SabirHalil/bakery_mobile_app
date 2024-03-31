
import 'dart:io';

import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/features/data/data_sources/remote/expense_service.dart';
import 'package:bakery_app/features/data/models/expense.dart';
import 'package:bakery_app/features/domain/entities/expense.dart';
import 'package:bakery_app/features/domain/repositories/expense_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/error/failures.dart';
import '../../../core/utils/toast_message.dart';


class ExpenseRepositoryImpl extends ExpenseRepository{
  final ExpenseService _expenseService;
  ExpenseRepositoryImpl(this._expenseService);
  @override
  Future<DataState<void>> addExpense(ExpenseEntity expense) async{
 try {
      final httpResponse = await _expenseService.addExpense( ExpenseModel.fromEntity(expense));
      if (httpResponse.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          Failure(httpResponse.statusMessage!),
        );
      }
    } on DioException catch (e) {
       return DataFailed(Failure(e.response?.data ?? e.message)); 
    } catch (e) {
      showToastMessage(e.toString(), duration: 1);
      rethrow;
    }
  }

  @override
  Future<DataState<void>> deleteExpense(int id)async {
 try {
      final httpResponse = await _expenseService.deleteExpense( id);
      if (httpResponse.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
            Failure(httpResponse.statusMessage!),
        );
      }
    } on DioException catch (e) {
       return DataFailed(Failure(e.response?.data ?? e.message)); 
    } catch (e) {
      showToastMessage(e.toString(), duration: 1);
      rethrow;
    }
  }

  @override
  Future<DataState<List<ExpenseEntity>>> getExpenseListByDate(DateTime date)async {
   try {
      final httpResponse = await _expenseService.getExpenseListByDate( date);
      if (httpResponse.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
           Failure(httpResponse.statusMessage!),
        );
      }
    } on DioException catch (e) {
       return DataFailed(Failure(e.response?.data ?? e.message)); 
    } catch (e) {
      showToastMessage(e.toString(), duration: 1);
      rethrow;
    }
  }

  @override
  Future<DataState<void>> updateExpense(ExpenseEntity expense)async {
 try {
      final httpResponse = await _expenseService.updateExpense(ExpenseModel.fromEntity(expense));
      if (httpResponse.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
             Failure(httpResponse.statusMessage!),
        );
      }
    } on DioException catch (e) {
       return DataFailed(Failure(e.response?.data ?? e.message)); 
    } catch (e) {
      showToastMessage(e.toString(), duration: 1);
      rethrow;
    }
  }
  
}
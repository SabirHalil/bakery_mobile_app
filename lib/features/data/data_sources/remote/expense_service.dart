import 'package:bakery_app/features/data/models/expense.dart';
import 'package:dio/dio.dart';

class ExpenseService {
    Dio dio;
  ExpenseService(this.dio);

  Future<Response> getExpenseListByDate(DateTime date) async {
    return await dio.get(
      '/api/Expense/GetExpensesByDate',
      queryParameters: {'date': date},
    );
  }

  Future<Response> addExpense(ExpenseModel expense) async {
    return await dio.post('/api/Expense/AddExpense', data: expense.toJson());
  }

  Future<Response> deleteExpense(int id) async {
    return await dio.delete('/api/Expense/DeleteExpense', queryParameters: {'id': id});
  }

  Future<Response> updateExpense(ExpenseModel expense) async {
    return await dio.put('/api/Expense/UpdateExpense', data: expense.toJson());
  }
}

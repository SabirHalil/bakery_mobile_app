import 'package:bakery_app/features/data/models/expense.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';

part 'expense_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ExpenseService {
  factory ExpenseService(Dio dio, String baseUrl) = _ExpenseService;
  @GET("/api/Expense/GetExpensesByDate")
  Future<HttpResponse<List<ExpenseModel>>>
      getExpenseListByDate(@Query("date") DateTime date);
  @POST("/api/Expense/AddExpense")
  Future<HttpResponse> addExpense(
      @Body() ExpenseModel expense);
  @DELETE("/api/Expense/DeleteExpense")
  Future<HttpResponse> deleteExpense(
    @Query("id") int id);
  @PUT("/api/Expense/UpdateExpense")
  Future<HttpResponse> updateExpense(
      @Body() ExpenseModel expense);
}

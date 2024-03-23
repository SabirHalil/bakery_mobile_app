part of 'expense_bloc.dart';
@immutable
sealed class ExpenseState{
  const ExpenseState();
  
get expenseList => null;
}

final class ExpenseLoading extends ExpenseState {
  const ExpenseLoading();
}

final class ExpenseFailure extends ExpenseState {
  final String? error;
  const ExpenseFailure({this.error});
}

final class ExpenseSuccess extends ExpenseState {
  
  @override
  final List<ExpenseModel>? expenseList;
  
  const ExpenseSuccess(
      {this.expenseList});

}


import 'package:bakery_app/core/resources/data_state.dart';
import 'package:bakery_app/core/utils/toast_message.dart';
import 'package:bakery_app/features/data/models/expense.dart';
import 'package:bakery_app/features/domain/usecases/expense_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseUseCase _expenseUseCase;
  ExpenseBloc(this._expenseUseCase) : super(const ExpenseLoading()) {
    on<ExpenseGetListRequested>(onGetExpenseList);
    on<ExpensePostRequested>(onPostExpense);
    on<ExpenseUpdateRequested>(onUpdateExpense);
    on<ExpenseDeleteRequested>(onDeleteExpense);
  }

  void onGetExpenseList(
      ExpenseGetListRequested event, Emitter<ExpenseState> emit) async {
    emit(const ExpenseLoading());
    final dataState = await _expenseUseCase.getExpenseListByDate(event.date);
    if (dataState is DataSuccess) {
      emit(ExpenseSuccess(expenseList: dataState.data as List<ExpenseModel>));
    }

    if (dataState is DataFailed) {
      emit(ExpenseFailure(error: dataState.error!.message));
    }
  }

  void onPostExpense(
      ExpensePostRequested event, Emitter<ExpenseState> emit) async {

    emit(const ExpenseLoading());

    final dataState = await _expenseUseCase.addExpense(event.expense);

    if (dataState is DataSuccess) {
      emit(ExpenseSuccess(expenseList: [...?state.expenseList, event.expense]));
      showToastMessage('Gider başarıyla eklendi');
    }

    if (dataState is DataFailed) {
      emit(ExpenseFailure(error: dataState.error!.message));
    }
  }

  void onUpdateExpense(
      ExpenseUpdateRequested event, Emitter<ExpenseState> emit) async {
    final state = this.state;
    emit(const ExpenseLoading());
    final dataState = await _expenseUseCase.updateExpense(event.expense);

    if (dataState is DataSuccess) {
      emit(ExpenseSuccess(expenseList: [
        ...state.expenseList!.map((element) =>
            element.id == event.expense.id ? event.expense : element)
      ]));
      showToastMessage('Gider başarıyla güncellendi');
    }

    if (dataState is DataFailed) {
      emit(ExpenseFailure(error: dataState.error!.message));
    }
  }

  void onDeleteExpense(
      ExpenseDeleteRequested event, Emitter<ExpenseState> emit) async {
    final state = this.state;
    emit(const ExpenseLoading());

    final dataState = await _expenseUseCase.deleteExpense(event.expense.id);

    if (dataState is DataSuccess) {
      emit(ExpenseSuccess(
          expenseList: [...?state.expenseList]..remove(event.expense)));
          showToastMessage('Gider başarıyla silindi');
    }

    if (dataState is DataFailed) {
      emit(ExpenseFailure(error: dataState.error!.message));
    }
  }
}

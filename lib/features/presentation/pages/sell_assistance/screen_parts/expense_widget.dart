import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/global_variables.dart';
import '../../../../data/models/expense.dart';
import '../../../widgets/custom_confirmation_dialog.dart';
import '../../../widgets/custom_expense_dialog.dart';
import '../../../widgets/custom_sell_list_tile.dart';
import '../../../widgets/empty_content.dart';
import '../../../widgets/error_animation.dart';
import '../../../widgets/loading_indicator.dart';
import '../bloc/expense/expense_bloc.dart';

class ExpenseWidget extends StatelessWidget {
  final DateTime selectedDate;
  final bool isAdmin;
  final int userId;
  final bool todayDate;
  const ExpenseWidget(
      {super.key,
      required this.selectedDate,
      required this.isAdmin,
      required this.userId,
      required this.todayDate});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: GlobalVariables.secondaryColorLight,
        ),
        child: CustomSellListTile(
            title: 'Gider',
            onShowDetails: () {
              _showExpenseList(context);
            },
            onAdd: todayDate || isAdmin
                ? () {
                    _addExpense(context);
                  }
                : null));
  }

  _showExpenseList(BuildContext context) {
    context
        .read<ExpenseBloc>()
        .add(ExpenseGetListRequested(date: selectedDate));
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<ExpenseBloc, ExpenseState>(
              builder: ((context, state) {
            return switch (state) {
              ExpenseLoading() => const LoadingIndicator(),
              ExpenseFailure() => const ErrorAnimation(),
              ExpenseSuccess() => state.expenseList!.isEmpty
                  ? const EmptyContent()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: Text(
                              "Giderler Listesi",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.expenseList!.length,
                            itemBuilder: (context, index) {
                              return Material(
                                child: ListTile(
                                  tileColor: index.isOdd
                                      ? GlobalVariables.oddItemColor
                                      : GlobalVariables.evenItemColor,
                                  title: Text(state.expenseList![index].detail),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(state.expenseList![index].amount
                                          .toString()),
                                      Text(getFormattedDateTime(
                                          state.expenseList![index].date)),
                                    ],
                                  ),
                                  trailing: (todayDate &&
                                              userId ==
                                                  state.expenseList![index]
                                                      .userId) ||
                                          isAdmin
                                      ? Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                              IconButton(
                                                  onPressed: () {
                                                    _updateExpense(state
                                                        .expenseList![index],context);
                                                  },
                                                  icon: const Icon(Icons.edit),
                                                  color: GlobalVariables
                                                      .secondaryColor),
                                              IconButton(
                                                  onPressed: () {
                                                    _deleteExpense(state
                                                        .expenseList![index],context);
                                                  },
                                                  icon:
                                                      const Icon(Icons.delete),
                                                  color: GlobalVariables
                                                      .secondaryColor),
                                            ])
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
            };
          }));
        });
  }

  _deleteExpense(ExpenseModel expense, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomConfirmationDialog(
              title: 'Silme',
              content: '${expense.detail} gideri silmek için emin misiniz?',
              onTap: () {
                context
                    .read<ExpenseBloc>()
                    .add(ExpenseDeleteRequested(expense: expense));
              });
        });
  }

  _updateExpense(ExpenseModel expense, BuildContext context) {
    TextEditingController expenseAmountController =
        TextEditingController(text: expense.amount.toString());
    TextEditingController expenseNameController =
        TextEditingController(text: expense.detail);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomExpenseDialog(
              title: 'Gider Güncelle',
              expenseAmountController: expenseAmountController,
              expenseNameController: expenseNameController,
              onSave: (amount, name) {
                if (amount == expense.amount && name == expense.detail) {
                  return;
                }
                context.read<ExpenseBloc>().add(ExpenseUpdateRequested(
                    expense: ExpenseModel(
                        id: expense.id,
                        detail: name,
                        date: DateTime.now(),
                        amount: amount,
                        userId: expense.userId)));
              });
        });
  }

  _addExpense(BuildContext context) {
    TextEditingController expenseAmountController = TextEditingController();
    TextEditingController expenseNameController = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomExpenseDialog(
              title: 'Gider Ekle',
              expenseAmountController: expenseAmountController,
              expenseNameController: expenseNameController,
              onSave: (amount, name) {
                context.read<ExpenseBloc>().add(ExpensePostRequested(
                    expense: ExpenseModel(
                        id: 0,
                        detail: name,
                        date: DateTime.now(),
                        amount: amount,
                        userId: userId)));
              });
        });
  }
}

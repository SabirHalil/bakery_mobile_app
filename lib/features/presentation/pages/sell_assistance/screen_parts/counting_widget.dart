import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/global_variables.dart';
import '../../../../../core/utils/toast_message.dart';
import '../../../../data/models/bread_counting.dart';
import '../../../../data/models/cash_counting.dart';
import '../../../../data/models/product_counting_added.dart';
import '../../../../data/models/product_not_added.dart';
import '../../../widgets/custom_cash_counting_dialog.dart';
import '../../../widgets/custom_confirmation_dialog.dart';
import '../../../widgets/custom_receive_amount_dialog.dart';
import '../../../widgets/custom_sell_list_tile.dart';
import '../../../widgets/empty_content.dart';
import '../../../widgets/error_animation.dart';
import '../../../widgets/loading_indicator.dart';
import '../bloc/bread_counting/bread_counting_bloc.dart';
import '../bloc/cash_counting/cash_counting_bloc.dart';
import '../bloc/product_counting_added/product_counting_added_bloc.dart';
import '../bloc/product_counting_not_added/product_counting_not_added_bloc.dart';

class CountingWidget extends StatelessWidget {
    final DateTime selectedDate;
  final bool isAdmin;
  final int userId;
  final bool todayDate;
  const CountingWidget(
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
      child: ExpansionTile(
        collapsedIconColor: GlobalVariables.secondaryColor,
        iconColor: GlobalVariables.secondaryColor,
        title: const Text(
          'Sayım',
        ),
        children: [
          CustomSellListTile(
              title: 'Ekmek',
              onShowDetails: () {
                _updateBreadCounting(selectedDate,context);
              },
              onAdd: todayDate || isAdmin
                  ? () {
                      _addBreadCountingDialog(selectedDate,context);
                    }
                  : null),
          const Divider(
            height: 1,
            color: Colors.white,
            indent: 10,
            endIndent: 10,
          ),
          CustomSellListTile(
              title: 'Pasta',
              onShowDetails: () {
                _showAddedProductCountingList(1,context);
              },
              onAdd: todayDate || isAdmin
                  ? () {
                      _showProductCountingNotAddedList(1,context);
                    }
                  : null),
          const Divider(
            height: 1,
            color: Colors.white,
            indent: 10,
            endIndent: 10,
          ),
          CustomSellListTile(
              title: 'Börek',
              onShowDetails: () {
                _showAddedProductCountingList(2,context);
              },
              onAdd: todayDate || isAdmin
                  ? () {
                      _showProductCountingNotAddedList(2,context);
                    }
                  : null),
          const Divider(
            height: 1,
            color: Colors.white,
            indent: 10,
            endIndent: 10,
          ),
          CustomSellListTile(
              title: 'Dışardan Alınan',
              onShowDetails: () {
                _showAddedProductCountingList(3,context);
              },
              onAdd: todayDate || isAdmin
                  ? () {
                      _showProductCountingNotAddedList(3,context);
                    }
                  : null),
          const Divider(
            height: 1,
            color: Colors.white,
            indent: 10,
            endIndent: 10,
          ),
          // -------NEED TO BE DONE--------
          CustomSellListTile(
              title: 'Kasa',
              onShowDetails: () {
                _updateCashCountingDialog("Kasa Sayımı Güncelleme",context);
              },
              onAdd: todayDate || isAdmin
                  ? () {
                      _addCashCountingDialog("Kasa Sayımı",context);
                    }
                  : null),
        ],
      ),
    );
  }

   _addBreadCountingDialog(DateTime date, BuildContext context) {
    context
        .read<BreadCountingBloc>()
        .add(BreadCountingGetListRequested(date: date));
    TextEditingController controller = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<BreadCountingBloc, BreadCountingState>(
              builder: ((context, state) {
            return switch (state) {
              BreadCountingLoading() => const LoadingIndicator(),
              BreadCountingFailure() => const ErrorAnimation(),
              BreadCountingSuccess() => state.breadCounting != null
                  ? CustomConfirmationDialog(
                      title: "Uyarı",
                      onTap: () {},
                      content: "Ekmek sayımı yapılmış")
                  : CustomReceiveAmountDialog(
                      title: 'Toplam ekmek sayımı ',
                      controller: controller,
                      onSave: (enteredQuantity) {
                        if (enteredQuantity < 1) {
                          showToastMessage("Geçerli bir tutar girilmeli!");
                          return;
                        }
                        context.read<BreadCountingBloc>().add(
                            BreadCountingPostRequested(
                                breadCounting: BreadCountingModel(
                                    id: 0,
                                    userId: userId,
                                    quantity: enteredQuantity,
                                    date: selectedDate)));
                      })
            };
          }));
        });
  }

  _updateBreadCounting(DateTime date, BuildContext context) {
    context
        .read<BreadCountingBloc>()
        .add(BreadCountingGetListRequested(date: date));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<BreadCountingBloc, BreadCountingState>(
              builder: ((context, state) {
            return switch (state) {
              BreadCountingLoading() => const LoadingIndicator(),
              BreadCountingFailure() => const ErrorAnimation(),
              BreadCountingSuccess() => state.breadCounting == null
                  ? CustomConfirmationDialog(
                      title: "Uyarı",
                      onTap: () {},
                      content: "Ekmek sayımı daha yapılmadı")
                  : CustomReceiveAmountDialog(
                      title: 'Ekmek sayımı güncelleme',
                      controller: TextEditingController(
                          text: state.breadCounting!.quantity.toString()),
                      onSave: (enteredQuantity) {
                        if (enteredQuantity < 1) {
                          showToastMessage("Geçerli bir tutar girilmeli!");
                          return;
                        }
                        if (enteredQuantity == state.breadCounting!.quantity) {
                          return;
                        }
                        context.read<BreadCountingBloc>().add(
                            BreadCountingUpdateRequested(
                                breadCounting: BreadCountingModel(
                                    id: state.breadCounting!.id,
                                    userId: state.breadCounting!.userId,
                                    quantity: enteredQuantity,
                                    date: state.breadCounting!.date)));
                      })
            };
          }));
        });
  }

  _showProductCountingNotAddedList(int categoryId, BuildContext context) {
    context.read<ProductCountingNotAddedBloc>().add(
        GetProductCountingNotAddedRequested(
            date: selectedDate, categoryId: categoryId));
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<ProductCountingNotAddedBloc,
              ProductCountingNotAddedState>(builder: ((context, state) {
            return switch (state) {
              ProductCountingNotAddedLoading() => const LoadingIndicator(),
              ProductCountingNotAddedFailure() => const ErrorAnimation(),
              ProductCountingNotAddedSuccess() => state
                      .productNotAddedList!.isEmpty
                  ? const EmptyContent()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: Text(
                              "Ürünler Listesi",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.productNotAddedList!.length,
                            itemBuilder: (context, index) {
                              return Material(
                                child: ListTile(
                                  tileColor: index.isOdd
                                      ? GlobalVariables.oddItemColor
                                      : GlobalVariables.evenItemColor,
                                  title: Text(
                                      state.productNotAddedList![index].name!),
                                  trailing: todayDate || isAdmin
                                      ? IconButton(
                                          onPressed: () {
                                            _addProductCounting(state
                                                .productNotAddedList![index],context);
                                          },
                                          icon: const Icon(Icons.add),
                                          color: GlobalVariables.secondaryColor)
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

  _addProductCounting(ProductNotAddedModel product, BuildContext context) {
    TextEditingController controller = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomReceiveAmountDialog(
              title: '${product.name}',
              controller: controller,
              onSave: (quantity) {
                context.read<ProductCountingNotAddedBloc>().add(
                      PostProductCountingNotAddedRequested(
                          productNotAdded: product, productQuantity: quantity),
                    );
              });
        });
  }

  _showAddedProductCountingList(int categoryId, BuildContext context) {
    context.read<ProductCountingAddedBloc>().add(
        GetProductCountingAddedRequested(
            date: selectedDate, categoryId: categoryId));
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<ProductCountingAddedBloc,
              ProductCountingAddedState>(builder: ((context, state) {
            return switch (state) {
              ProductCountingAddedLoading() => const LoadingIndicator(),
              ProductCountingAddedFailure() => const ErrorAnimation(),
              ProductCountingAddedSuccess() => state
                      .productCountingAddedList!.isEmpty
                  ? const EmptyContent()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: Text(
                              "Ürünler Sayımı Listesi",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.productCountingAddedList!.length,
                            itemBuilder: (context, index) {
                              return Material(
                                child: ListTile(
                                  tileColor: index.isOdd
                                      ? GlobalVariables.oddItemColor
                                      : GlobalVariables.evenItemColor,
                                  title: Text(state
                                      .productCountingAddedList![index]
                                      .productName),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(state
                                          .productCountingAddedList![index]
                                          .quantity
                                          .toString()),
                                      Text(getFormattedDateTime(state
                                          .productCountingAddedList![index]
                                          .date)),
                                    ],
                                  ),
                                  trailing: todayDate || isAdmin
                                      ? Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                              IconButton(
                                                  onPressed: () {
                                                    _updateProductCountingAdded(
                                                        state.productCountingAddedList![
                                                            index],context);
                                                  },
                                                  icon: const Icon(Icons.edit),
                                                  color: GlobalVariables
                                                      .secondaryColor),
                                              IconButton(
                                                  onPressed: () {
                                                    _deleteProductCountingAdded(
                                                        state.productCountingAddedList![
                                                            index],context);
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

  _deleteProductCountingAdded(ProductCountingAddedModel productCountingAdded, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomConfirmationDialog(
              title: 'Silme',
              content:
                  '${productCountingAdded.productName} ürün sayımı silmek için emin misiniz?',
              onTap: () {
                context.read<ProductCountingAddedBloc>().add(
                    RemoveProductCountingAddedRequested(
                        productCountingAddedModel: productCountingAdded));
              });
        });
  }

  _updateProductCountingAdded(ProductCountingAddedModel productCountingAdded, BuildContext context) {
    TextEditingController controller =TextEditingController(text: productCountingAdded.quantity.toString());

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomReceiveAmountDialog(
              title: '${productCountingAdded.productName} Bayatı Güncelleme',
              controller: controller,
              onSave: (amount) {
                if (amount == productCountingAdded.quantity) {
                  return;
                }
                context
                    .read<ProductCountingAddedBloc>()
                    .add(UpdateProductCountingAddedRequested(
                      productCountingAddedModel: ProductCountingAddedModel(
                          id: productCountingAdded.id,
                          productName: productCountingAdded.productName,
                          quantity: amount,
                          productId: productCountingAdded.productId,
                          date: productCountingAdded.date),
                    ));
              });
        });
  }

  _addCashCountingDialog(String title,BuildContext context) {
    context
        .read<CashCountingBloc>()
        .add(CashCountingGetListRequested(date: selectedDate));

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<CashCountingBloc, CashCountingState>(
              builder: ((context, state) {
            return switch (state) {
              CashCountingLoading() => const LoadingIndicator(),
              CashCountingFailure() => const ErrorAnimation(),
              CashCountingSuccess() => state.cashCounting != null
                  ? CustomConfirmationDialog(
                      title: "Uyarı",
                      onTap: () {},
                      content: "Kasa sayımı yapılmış!")
                  : CustomCashCountingDialog(
                      title: title,
                      totalController: TextEditingController(),
                      creditcartController: TextEditingController(),
                      reminedController: TextEditingController(),
                      onSave: (totalCash, reminedCash, creditcard) {
                        context.read<CashCountingBloc>().add(
                            CashCountingPostRequested(
                                cashCounting: CashCountingModel(
                                    id: 0,
                                    creditCard: creditcard,
                                    totalMoney: totalCash,
                                    remainedMoney: reminedCash,
                                    date: selectedDate)));
                      })
            };
          }));
        });
  }

  _updateCashCountingDialog(String title, BuildContext context) {
    context
        .read<CashCountingBloc>()
        .add(CashCountingGetListRequested(date: selectedDate));

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<CashCountingBloc, CashCountingState>(
              builder: ((context, state) {
            return switch (state) {
              CashCountingLoading() => const LoadingIndicator(),
              CashCountingFailure() => const ErrorAnimation(),
              CashCountingSuccess() => state.cashCounting == null
                  ? CustomConfirmationDialog(
                      title: "Uyarı",
                      onTap: () {},
                      content: "Kasa sayımı daha yapılmadı!")
                  : CustomCashCountingDialog(
                      title: title,
                      totalController: TextEditingController(
                          text: state.cashCounting!.totalMoney.toString()),
                      creditcartController: TextEditingController(
                          text: state.cashCounting!.creditCard.toString()),
                      reminedController: TextEditingController(
                          text: state.cashCounting!.remainedMoney.toString()),
                      onSave: (totalCash, reminedCash, creditcard) {
                        if (totalCash == state.cashCounting!.totalMoney &&
                            state.cashCounting!.remainedMoney == reminedCash &&
                            creditcard == state.cashCounting!.creditCard) {
                          return;
                        }
                        context.read<CashCountingBloc>().add(
                            CashCountingUpdateRequested(
                                cashCounting: CashCountingModel(
                                    id: state.cashCounting!.id,
                                    creditCard: creditcard,
                                    totalMoney: totalCash,
                                    remainedMoney: reminedCash,
                                    date: state.cashCounting!.date)));
                      })
            };
          }));
        });
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/global_variables.dart';
import '../../../../data/models/product_not_added.dart';
import '../../../../data/models/stale_bread.dart';
import '../../../../data/models/stale_bread_added.dart';
import '../../../../data/models/stale_product_added.dart';
import '../../../widgets/custom_confirmation_dialog.dart';
import '../../../widgets/custom_receive_amount_dialog.dart';
import '../../../widgets/custom_sell_list_tile.dart';
import '../../../widgets/empty_content.dart';
import '../../../widgets/error_animation.dart';
import '../../../widgets/loading_indicator.dart';
import '../bloc/stale_bread/stale_bread_bloc.dart';
import '../bloc/stale_bread_products/stale_bread_products_bloc.dart';
import '../bloc/stale_product/stale_product_bloc.dart';
import '../bloc/stale_product_products/stale_product_products_bloc.dart';

class StaleWidget extends StatelessWidget {
    final DateTime selectedDate;
  final bool isAdmin;

  final bool todayDate;
  const StaleWidget(
     {super.key,
      required this.selectedDate,
      required this.isAdmin,
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
          'Bayat',
        ),
        children: [
          CustomSellListTile(
              title: 'Ekmek',
              onShowDetails:()=> _showStaleBreadList(context),
              onAdd: todayDate || isAdmin ? ()=> _showStaleBreadProductList(context) : null),
          const Divider(
            height: 1,
            color: Colors.white,
            indent: 10,
            endIndent: 10,
          ),
          CustomSellListTile(
              title: 'Pasta',
              onShowDetails: () {
                _showStaleAddedProductList(1,context);
              },
              onAdd: todayDate || isAdmin
                  ? () {
                      _showStaleProductList(1,context);
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
                _showStaleAddedProductList(2,context);
              },
              onAdd: todayDate || isAdmin
                  ? () {
                      _showStaleProductList(2,context);
                    }
                  : null)
        ],
      ),
    );
  }

   _showStaleBreadList(BuildContext context) {
    context
        .read<StaleBreadBloc>()
        .add(GetStaleBreadRequested(date: selectedDate));
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<StaleBreadBloc, StaleBreadState>(
              builder: ((context, state) {
            return switch (state) {
              StaleBreadLoading() => const LoadingIndicator(),
              StaleBreadFailure() => const ErrorAnimation(),
              StaleBreadSuccess() => state.staleBreadList!.isEmpty
                  ? const EmptyContent()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: Text(
                              "Bayat Ekmek Listesi",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.staleBreadList!.length,
                            itemBuilder: (context, index) {
                              return Material(
                                child: ListTile(
                                  tileColor: index.isOdd
                                      ? GlobalVariables.oddItemColor
                                      : GlobalVariables.evenItemColor,
                                  title: Text(state.staleBreadList![index]
                                      .doughFactoryProductName),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(state.staleBreadList![index].quantity
                                          .toString()),
                                      Text(getFormattedDateTime(
                                          state.staleBreadList![index].date)),
                                    ],
                                  ),
                                  trailing: todayDate || isAdmin
                                      ? Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                              IconButton(
                                                  onPressed: () {
                                                    _updateStaleBreadAdded(
                                                        state.staleBreadList![
                                                            index],context);
                                                  },
                                                  icon: const Icon(Icons.edit),
                                                  color: GlobalVariables
                                                      .secondaryColor),
                                              IconButton(
                                                  onPressed: () {
                                                    _deleteStaleBreadAdded(
                                                        state.staleBreadList![
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

  _deleteStaleBreadAdded(StaleBreadAddedModel staleBreadAdded,BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomConfirmationDialog(
              title: 'Silme',
              content:
                  '${staleBreadAdded.doughFactoryProductName} bayatı silmek için emin misiniz?',
              onTap: () {
                context.read<StaleBreadBloc>().add(RemoveStaleBreadRequested(
                    staleBreadAddedModel: staleBreadAdded));
              });
        });
  }

  _updateStaleBreadAdded(StaleBreadAddedModel staleBreadAdded,BuildContext context) {
    TextEditingController controller =
        TextEditingController(text: staleBreadAdded.quantity.toString());

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomReceiveAmountDialog(
              title:
                  '${staleBreadAdded.doughFactoryProductName} Bayatı Güncelleme',
              controller: controller,
              onSave: (amount) {
                if (amount == staleBreadAdded.quantity) {
                  return;
                }
                context.read<StaleBreadBloc>().add(UpdateStaleBreadRequested(
                        staleBreadAddedModel: StaleBreadAddedModel(
                      id: staleBreadAdded.id,
                      doughFactoryProductId:
                          staleBreadAdded.doughFactoryProductId,
                      quantity: amount,
                      date: staleBreadAdded.date,
                      doughFactoryProductName:
                          staleBreadAdded.doughFactoryProductName,
                    )));
              });
        });
  }

  _showStaleBreadProductList(BuildContext context) {
    context
        .read<StaleBreadProductsBloc>()
        .add(GetStaleBreadProductsRequested(date: selectedDate));
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<StaleBreadProductsBloc, StaleBreadProductsState>(
              builder: ((context, state) {
            return switch (state) {
              StaleBreadProductsLoading() => const LoadingIndicator(),
              StaleBreadProductsFailure() => const ErrorAnimation(),
              StaleBreadProductsSuccess() => state
                      .staleBreadProductsList!.isEmpty
                  ? const EmptyContent()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: Text(
                              "Ekmek Ürünleri Listesi",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.staleBreadProductsList!.length,
                            itemBuilder: (context, index) {
                              return Material(
                                child: ListTile(
                                  tileColor: index.isOdd
                                      ? GlobalVariables.oddItemColor
                                      : GlobalVariables.evenItemColor,
                                  title: Text(state
                                      .staleBreadProductsList![index].name),
                                  trailing: todayDate || isAdmin
                                      ? IconButton(
                                          onPressed: () {
                                            _addStaleBreadProduct(
                                                state.staleBreadProductsList![
                                                    index],context);
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

  _addStaleBreadProduct(StaleBreadModel staleBread,BuildContext context) {
    TextEditingController controller = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomReceiveAmountDialog(
              title: 'Bayat ${staleBread.name}',
              controller: controller,
              onSave: (amount) {
                context.read<StaleBreadProductsBloc>().add(
                      PostStaleBreadProductsRequested(
                          staleBreadModel: staleBread, staleQuantity: amount),
                    );
              });
        });
  }

  _showStaleAddedProductList(int categoryId,BuildContext context) {
    context.read<StaleProductBloc>().add(GetStaleAddedProductRequested(
        date: selectedDate, categoryId: categoryId));
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<StaleProductBloc, StaleProductState>(
              builder: ((context, state) {
            return switch (state) {
              StaleAddedProductLoading() => const LoadingIndicator(),
              StaleAddedProductFailure() => const ErrorAnimation(),
              StaleAddedProductSuccess() => state.staleAddedProductList!.isEmpty
                  ? const EmptyContent()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: Text(
                              "Bayat Ürünler Listesi",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.staleAddedProductList!.length,
                            itemBuilder: (context, index) {
                              return Material(
                                child: ListTile(
                                  tileColor: index.isOdd
                                      ? GlobalVariables.oddItemColor
                                      : GlobalVariables.evenItemColor,
                                  title: Text(state
                                      .staleAddedProductList![index]
                                      .productName),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(state.staleAddedProductList![index]
                                          .quantity
                                          .toString()),
                                      Text(getFormattedDateTime(state
                                          .staleAddedProductList![index].date)),
                                    ],
                                  ),
                                  trailing: todayDate || isAdmin
                                      ? Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                              IconButton(
                                                  onPressed: () {
                                                    _updateStaleProductAdded(
                                                        state.staleAddedProductList![
                                                            index],context);
                                                  },
                                                  icon: const Icon(Icons.edit),
                                                  color: GlobalVariables
                                                      .secondaryColor),
                                              IconButton(
                                                  onPressed: () {
                                                    _deleteStaleProductAdded(
                                                        state.staleAddedProductList![
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

  _deleteStaleProductAdded(StaleProductAddedModel staleProductAdded,BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomConfirmationDialog(
              title: 'Silme',
              content:
                  '${staleProductAdded.productName} bayatı silmek için emin misiniz?',
              onTap: () {
                context.read<StaleProductBloc>().add(
                    RemoveStaleAddedProductRequested(
                        staleProductAddedModel: staleProductAdded));
              });
        });
  }

  _updateStaleProductAdded(StaleProductAddedModel staleProductAdded,BuildContext context) {
    TextEditingController controller =
        TextEditingController(text: staleProductAdded.quantity.toString());

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomReceiveAmountDialog(
              title: '${staleProductAdded.productName} Bayatı Güncelleme',
              controller: controller,
              onSave: (amount) {
                if (amount == staleProductAdded.quantity) {
                  return;
                }
                context
                    .read<StaleProductBloc>()
                    .add(UpdateStaleAddedProductRequested(
                        staleProductAddedModel: StaleProductAddedModel(
                      id: staleProductAdded.id,
                      productName: staleProductAdded.productName,
                      quantity: amount,
                      date: staleProductAdded.date,
                      productId: staleProductAdded.productId,
                    )));
              });
        });
  }

  _showStaleProductList(int categoryId,BuildContext context) {
    context.read<StaleProductProductsBloc>().add(
        GetStaleProductsRequested(date: selectedDate, categoryId: categoryId));
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<StaleProductProductsBloc,
              StaleProductProductsState>(builder: ((context, state) {
            return switch (state) {
              StaleProductsLoading() => const LoadingIndicator(),
              StaleProductsFailure() => const ErrorAnimation(),
              StaleProductsSuccess() => state.staleProductsList!.isEmpty
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
                            itemCount: state.staleProductsList!.length,
                            itemBuilder: (context, index) {
                              return Material(
                                child: ListTile(
                                  tileColor: index.isOdd
                                      ? GlobalVariables.oddItemColor
                                      : GlobalVariables.evenItemColor,
                                  title: Text(
                                      state.staleProductsList![index].name!),
                                  trailing: todayDate || isAdmin
                                      ? IconButton(
                                          onPressed: () {
                                            _addStaleProduct(state
                                                .staleProductsList![index],context);
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

  _addStaleProduct(ProductNotAddedModel staleBread,BuildContext context) {
    TextEditingController controller = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomReceiveAmountDialog(
              title: 'Bayat ${staleBread.name}',
              controller: controller,
              onSave: (amount) {
                context.read<StaleProductProductsBloc>().add(
                      PostStaleProductsRequested(
                          staleBreadModel: staleBread, staleQuantity: amount),
                    );
              });
        });
  }

}
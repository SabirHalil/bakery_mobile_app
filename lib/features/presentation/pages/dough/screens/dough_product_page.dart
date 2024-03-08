import 'dart:async';

import 'package:bakery_app/core/utils/toast_message.dart';
import 'package:bakery_app/features/data/data_sources/local/shared_preference.dart';
import 'package:bakery_app/features/data/models/dough_added_product.dart';
import 'package:bakery_app/features/data/models/dough_product_to_add.dart';
import 'package:bakery_app/features/data/models/product_not_added.dart';
import 'package:bakery_app/features/presentation/widgets/added_product.dart';
import 'package:bakery_app/features/presentation/widgets/available_product.dart';
import 'package:bakery_app/features/presentation/widgets/custom_app_bar.dart';
import 'package:bakery_app/features/presentation/widgets/custom_save_button.dart';
import 'package:bakery_app/features/presentation/widgets/custom_update_quantity_dialog.dart';
import 'package:bakery_app/features/presentation/widgets/editable_added_product.dart';
import 'package:bakery_app/features/presentation/widgets/empty_content.dart';
import 'package:bakery_app/features/presentation/widgets/error_animation.dart';
import 'package:bakery_app/features/presentation/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/custom_confirmation_dialog.dart';
import '../bloc/dough_added_products/dough_added_products_bloc.dart';
import '../bloc/dough_products/dough_products_bloc.dart';

class DoughProductPage extends StatelessWidget {
  static const String routeName = "dough-products-page";
  int listId;
  final bool canEdit;
  final DateTime date;
  DoughProductPage(
      {super.key,
      required this.listId,
      required this.canEdit,
      required this.date});

  final List<DoughProductToAddModel> listToPost = List.empty(growable: true);
 
  @override
  Widget build(BuildContext context) {
     print("List id: $listId");
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          title: "Hamurhane",
          onTap: () {
            Navigator.pop(context);
          },
        ),
        body: _buildBody(context));
  }

  _buildBody(BuildContext context) {
    if (canEdit) {
      return LayoutBuilder(builder: (context, constraints) {
        double screenHeight = constraints.maxHeight;
        double sectionHeight = screenHeight * 0.46;
        double buttonHeight = screenHeight * 0.08;

        return Column(
          children: [
            SizedBox(
              height: sectionHeight,
              child: _getAvailableProducts(context),
            ),
            SizedBox(
              height: sectionHeight,
              child: _getEditableAddedProducts(context),
            ),
            SizedBox(
              width: double.infinity,
              height: buttonHeight,
              child: CustomSaveButton(
                onTap: () {
                  _saveNewProducts(context);
                },
                text: "Kaydet",
              ),
            ),
          ],
        );
      });
    } else {
      return _getAddedProducts(context);
    }
  }

  _getAddedProducts(BuildContext context) {
    context
        .read<DoughAddedProductsBloc>()
        .add(DoughGetAddedProductsRequested(listId: listId));
    return BlocBuilder<DoughAddedProductsBloc, DoughAddedProductsState>(
        builder: ((context, state) {
      return switch (state) {
        DoughAddedProductsLoading() => const LoadingIndicator(),
        DoughAddedProductsFailure() => const ErrorAnimation(),
        DoughAddedProductsSuccess() => state.doughAddedProducts!.isEmpty
            ? const EmptyContent()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        "Yapılan Liste",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.doughAddedProducts!.length,
                      itemBuilder: (context, index) {
                        return AddedProduct(
                            productName: state.doughAddedProducts![index]
                                .doughFactoryProductName!,
                            quantity:
                                state.doughAddedProducts![index].quantity!,
                            index: index);
                      },
                    ),
                  ),
                ],
              )
      };
    }));
  }

  _getEditableAddedProducts(BuildContext context) {
    context
        .read<DoughAddedProductsBloc>()
        .add(DoughGetAddedProductsRequested(listId: listId));
    return BlocBuilder<DoughAddedProductsBloc, DoughAddedProductsState>(
        builder: ((context, state) {
      if (state is DoughAddedProductsSuccess &&
          state.listId != null &&
          state.listId != 0) {
        listId = state.listId!;
      }
      return switch (state) {
        DoughAddedProductsLoading() => const LoadingIndicator(),
        DoughAddedProductsFailure() => const ErrorAnimation(),
        DoughAddedProductsSuccess() => state.doughAddedProducts!.isEmpty
            ? const EmptyContent()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        "Yapılan Liste",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.doughAddedProducts!.length,
                      itemBuilder: (context, index) {
                        return EditableAddedProduct(
                            productName: state.doughAddedProducts![index]
                                .doughFactoryProductName!,
                            quantity:
                                state.doughAddedProducts![index].quantity!,
                            onEditPressed: () {
                              _updateAddedProduct(context,
                                  state.doughAddedProducts![index], index);
                            },
                            onDeletePressed: () {
                              _removeAddedProduct(
                                  context, state.doughAddedProducts![index]);
                            },
                            index: index);
                      },
                    ),
                  ),
                ],
              ),
      };
    }));
  }

  _getAvailableProducts(BuildContext context) {
    List<TextEditingController> controllers = List.empty(growable: true);
    context
        .read<DoughProductsBloc>()
        .add(DoughGetProductsRequested(listId: listId));

    return BlocBuilder<DoughProductsBloc, DoughProductsState>(
        builder: ((context, state) {
      return switch (state) {
        DoughProductsLoading() => const LoadingIndicator(),
        DoughProductsFailure() => const ErrorAnimation(),
        DoughProductsSuccess() => state.doughProducts!.isEmpty
            ? const EmptyContent()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(8),
                    child: const Center(
                      child: Text(
                        "Ürünler Listsi",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.doughProducts!.length,
                      itemBuilder: (context, index) {
                        controllers.add(TextEditingController());
                        return AvailableProductWidget(
                            productName: state.doughProducts![index].name!,
                            controller: controllers[index],
                            index: index,
                            onPressed: () {
                              if (controllers[index].text.isNotEmpty &&
                                  controllers[index].text != "0") {
                                _addProductToAddedList(
                                    context,
                                    state.doughProducts![index],
                                    int.parse(controllers[index].text));
                                controllers[index].clear();
                              } else {
                                showToastMessage("Bir sayı girmelisiniz!");
                              }
                            });
                      },
                    ),
                  ),
                ],
              ),
      };
    }));
  }

  _saveNewProducts(BuildContext context) async {
    if (listToPost.isNotEmpty) {
      var user = await UserPreferences.getUser();
      if (user != null) {
        context.read<DoughAddedProductsBloc>().add(DoughPostAddedProductRequested(products: listToPost, userId: user.id!, date: date));
      }
    } else {
      showToastMessage("Yeni ürün eklemelisiniz!");
    }
  }

  _updateAddedProduct(BuildContext context,
      DoughAddedProductModel addedProductModel, int index) {
    TextEditingController controller =
        TextEditingController(text: addedProductModel.quantity.toString());
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return UpdateQuantityDialog(
              controller: controller,
              onSave: (newQuantity) {
                if (newQuantity == addedProductModel.quantity) {
                  return;
                }
                if (addedProductModel.id == 0 && listToPost.isNotEmpty) {
                  int indexToUpdate = listToPost.indexWhere((element) =>
                      element.doughFactoryProductId ==
                      addedProductModel.doughFactoryProductId);

                  if (indexToUpdate != -1) {
                    // Check if the item is found in the list
                    DoughProductToAddModel updatedProduct =
                        DoughProductToAddModel(
                      id: 0,
                      doughFactoryProductId:
                          listToPost[indexToUpdate].doughFactoryProductId,
                      quantity: newQuantity,
                      doughFactoryListId:
                          listToPost[indexToUpdate].doughFactoryListId,
                    );

                    listToPost[indexToUpdate] = updatedProduct;
                  }
                }

                context.read<DoughAddedProductsBloc>().add(
                    DoughUpdateAddedProductRequested(
                        product: DoughAddedProductModel(
                            id: addedProductModel.id,
                            doughFactoryProductId:
                                addedProductModel.doughFactoryProductId,
                            doughFactoryListId:
                                addedProductModel.doughFactoryListId,
                            doughFactoryProductName:
                                addedProductModel.doughFactoryProductName,
                            quantity: newQuantity),
                        index: index));
              },
              title: "Güncelleme",
              content:
                  "${addedProductModel.doughFactoryProductName!} adedini güncellemek için emin misiniz?");
        });
  }

  _removeAddedProduct(
      BuildContext context, DoughAddedProductModel addedProduct) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomConfirmationDialog(
              title: 'Silme',
              content:
                  '${addedProduct.doughFactoryProductName}\'in listeden silmek için emin misiniz?',
              onTap: () {
                if (listToPost.isNotEmpty) {
                  listToPost.removeWhere((element) =>
                      element.doughFactoryProductId ==
                      addedProduct.doughFactoryProductId);
                }
                context.read<DoughAddedProductsBloc>().add(
                    DoughRemoveAddedProductRequested(product: addedProduct));
                context.read<DoughProductsBloc>().add(DoughAddProductRequested(
                    product: ProductNotAddedModel(
                        id: addedProduct.doughFactoryProductId,
                        name: addedProduct.doughFactoryProductName)));
              });
        });
  }

  _addProductToAddedList(
      BuildContext context, ProductNotAddedModel productModel, int quantity) {
    context
        .read<DoughProductsBloc>()
        .add(DoughRemoveProductRequested(product: productModel));
    context.read<DoughAddedProductsBloc>().add(DoughAddAddedProductRequested(
        product: DoughAddedProductModel(
            id: 0,
            doughFactoryListId: listId,
            doughFactoryProductId: productModel.id,
            doughFactoryProductName: productModel.name,
            quantity: quantity)));

    listToPost.add(DoughProductToAddModel(
        doughFactoryProductId: productModel.id,
        doughFactoryListId: listId,
        quantity: quantity));
  }
  
}

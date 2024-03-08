// ignore_for_file: use_build_context_synchronously

import 'package:bakery_app/features/data/models/user.dart';
import 'package:bakery_app/features/presentation/pages/production/bloc/added_products/added_product_bloc.dart';
import 'package:bakery_app/features/presentation/pages/production/bloc/products/product_bloc.dart';
import 'package:bakery_app/features/presentation/widgets/custom_app_bar_with_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/is_today_check.dart';
import '../../../../../core/utils/toast_message.dart';
import '../../../../data/models/product.dart';
import '../../../../data/models/product_added.dart';
import '../../../../data/models/product_to_add.dart';
import '../../../widgets/added_product.dart';
import '../../../widgets/available_product.dart';
import '../../../widgets/custom_confirmation_dialog.dart';
import '../../../widgets/custom_save_button.dart';
import '../../../widgets/custom_update_quantity_dialog.dart';
import '../../../widgets/editable_added_product.dart';
import '../../../widgets/empty_content.dart';
import '../../../widgets/error_animation.dart';
import '../../../widgets/loading_indicator.dart';

class ProductionPage extends StatefulWidget {
  static const String routeName = "production-page";
  final UserModel user;
  final int? categoryId;
  const ProductionPage({super.key, required this.user, this.categoryId});

  @override
  State<ProductionPage> createState() => _ProductionPageState();
}

class _ProductionPageState extends State<ProductionPage> {
  static String? date = "Bugün";
  static bool todayDate = true;
  static DateTime? selectedDate = DateTime.now();
  static bool isAdmin = false;
  int categoryId = 1;
  late UserModel user;
  final List<ProductToAddModel> listToPost = List.empty(growable: true);
  String pageTitle = '';
  @override
  void initState() {
    super.initState();
    user = widget.user;
    isAdmin = isAdminCheck(user.token!);
    date = isAdmin ? "Bugün" : null;
    if (widget.categoryId != null) {
      categoryId = widget.categoryId!;
      _setPageTitleAndCategoryId(categoryId);
    } else {
      _setPageTitleAndCategoryIdByoperationClaimId(user.operationClaim!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  _buildBody() {
    if (todayDate || isAdmin) {
      return LayoutBuilder(builder: (context, constraints) {
        double screenHeight = constraints.maxHeight;
        double sectionHeight = screenHeight * 0.46;
        double buttonHeight = screenHeight * 0.08;

        return Column(
          children: [
            SizedBox(
              height: sectionHeight,
              child: _getAvailableProducts(),
            ),
            SizedBox(
              height: sectionHeight,
              child: _getEditableAddedProducts(),
            ),
            SizedBox(
              width: double.infinity,
              height: buttonHeight,
              child: CustomSaveButton(
                onTap: () {
                  _saveNewProducts();
                },
                text: "Kaydet",
              ),
            ),
          ],
        );
      });
    } else {
      return _getAddedProducts();
    }
  }

  _getAddedProducts() {
    context.read<AddedProductBloc>().add(
        GetAddedProductsRequested(date: selectedDate!, categoryId: categoryId));
    return BlocBuilder<AddedProductBloc, AddedProductState>(
        builder: ((context, state) {
      return switch (state) {
        AddedProductLoading() => const LoadingIndicator(),
        AddedProductFailure() => const ErrorAnimation(),
        AddedProductSuccess() => state.addedProducts!.isEmpty
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
                      itemCount: state.addedProducts!.length,
                      itemBuilder: (context, index) {
                        return AddedProduct(
                            productName:
                                state.addedProducts![index].productName!,
                            quantity: state.addedProducts![index].quantity!,
                            index: index);
                      },
                    ),
                  ),
                ],
              )
      };
    }));
  }

  _getEditableAddedProducts() {
    context.read<AddedProductBloc>().add(
        GetAddedProductsRequested(date: selectedDate!, categoryId: categoryId));
    return BlocBuilder<AddedProductBloc, AddedProductState>(
        builder: ((context, state) {
      return switch (state) {
        AddedProductLoading() => const LoadingIndicator(),
        AddedProductFailure() => const ErrorAnimation(),
        AddedProductSuccess() => state.addedProducts!.isEmpty
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
                      itemCount: state.addedProducts!.length,
                      itemBuilder: (context, index) {
                        return EditableAddedProduct(
                            productName:
                                state.addedProducts![index].productName!,
                            quantity: state.addedProducts![index].quantity!,
                            onEditPressed: () {
                              _updateAddedProduct(
                                  state.addedProducts![index], index);
                            },
                            onDeletePressed: () {
                              _removeAddedProduct(
                                  context, state.addedProducts![index]);
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

  _getAvailableProducts() {
    List<TextEditingController> controllers = List.empty(growable: true);
    context
        .read<ProductBloc>()
        .add(GetProductsRequested(date: selectedDate!, categoryId: categoryId));

    return BlocBuilder<ProductBloc, ProductState>(builder: ((context, state) {
      return switch (state) {
        ProductLoading() => const LoadingIndicator(),
        ProductFailure() => const ErrorAnimation(),
        ProductSuccess() => state.products!.isEmpty
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
                      itemCount: state.products!.length,
                      itemBuilder: (context, index) {
                        controllers.add(TextEditingController());
                        return AvailableProductWidget(
                            productName: state.products![index].name!,
                            controller: controllers[index],
                            index: index,
                            onPressed: () {
                              if (controllers[index].text.isNotEmpty) {
                                _addProductToAddedList(
                                    context,
                                    state.products![index],
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

  _saveNewProducts() async {
    if (listToPost.isNotEmpty) {
      context.read<AddedProductBloc>().add(PostAddedProductRequested(
          products: listToPost,
          userId: user.id!,
          categoryId: categoryId,
          date: selectedDate!));
    } else {
      showToastMessage("Yeni ürün eklemelisiniz!");
    }
  }

  _updateAddedProduct(AddedProductModel addedProductModel, int index) {
    TextEditingController controller =
        TextEditingController(text: addedProductModel.quantity.toString());
    
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return UpdateQuantityDialog(
              controller: controller,
              onSave: (newQuantity) {
                if (newQuantity != addedProductModel.quantity) {
                  context.read<AddedProductBloc>().add(
                      UpdateAddedProductRequested(
                          product: AddedProductModel(
                              id: addedProductModel.id,
                              productId: addedProductModel.productId,
                              productListId: addedProductModel.productListId,
                              productName: addedProductModel.productName,
                              quantity: newQuantity),
                          index: index));
                }
              },
              title: "Güncelleme",
              content:
                  "${addedProductModel.productName!} adedini güncellemek için emin misiniz?");
        });
  }

  _removeAddedProduct(BuildContext context, AddedProductModel addedProduct) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomConfirmationDialog(
              title: 'Silme',
              content:
                  '${addedProduct.productName}\'in listeden silmek için emin misiniz?',
              onTap: () {
                context
                    .read<AddedProductBloc>()
                    .add(RemoveAddedProductRequested(product: addedProduct));
                context.read<ProductBloc>().add(AddProductRequested(
                    product: ProductModel(
                        id: addedProduct.productId,
                        name: addedProduct.productName)));
              });
        });
  }

  _addProductToAddedList(
      BuildContext context, ProductModel productModel, int quantity) {
    context
        .read<ProductBloc>()
        .add(RemoveProductRequested(product: productModel));
    context.read<AddedProductBloc>().add(AddAddedProductRequested(
        product: AddedProductModel(
            id: 0,
            productListId: 0,
            productId: productModel.id,
            productName: productModel.name,
            quantity: quantity)));

    listToPost.add(ProductToAddModel(
        id: 0,
        price: 0,
        productId: productModel.id,
        productionListId: 0,
        quantity: quantity));
  }

  _buildAppbar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: CustomAppBarWithDate(
        title: pageTitle,
        date: date,
        onTap: _selectDate,
      ),
    );
  }

  Future<void> _selectDate() async {
    var newDate = await showDatePicker(
      context: context,
      initialDate: selectedDate!,
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
      locale: const Locale('tr', 'TR'),
    );

    if (selectedDate != null && newDate != null && !checkDate(newDate)) {
      selectedDate = newDate;
      setState(() {
        todayDate = isToday(selectedDate!);
        if (todayDate) {
          date = 'Bugün';
          context.read<AddedProductBloc>().add(GetAddedProductsRequested(
              date: selectedDate!, categoryId: categoryId));
          context.read<ProductBloc>().add(GetProductsRequested(
              date: selectedDate!, categoryId: user.operationClaim!));
        } else {
          date = selectedDate.toString().split(" ")[0];
        }
      });
    }
  }

  bool checkDate(DateTime newDate) {
    return newDate.year == selectedDate!.year &&
        newDate.month == selectedDate!.month &&
        newDate.day == selectedDate!.day;
  }

  _setPageTitleAndCategoryIdByoperationClaimId(int operationClaimId) {
    switch (operationClaimId) {
      case 2:
        {
          pageTitle = 'Pastane';
          categoryId = 1;
        }
      case 3:
        {
          pageTitle = 'Hamur işi';
          categoryId = 2;
        }
      case 5:
        {
          pageTitle = 'Dışardan Alınan Ürünler';
          categoryId = 3;
        }
    }
  }

  _setPageTitleAndCategoryId(int categoryId) {
    switch (categoryId) {
      case 1:
        pageTitle = 'Pastane';
      case 2:
        pageTitle = 'Hamur işi';
      case 3:
        pageTitle = 'Dışardan Alınan Ürünler';
    }
  }
}

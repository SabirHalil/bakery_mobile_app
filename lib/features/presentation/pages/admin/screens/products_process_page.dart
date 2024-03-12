import 'package:bakery_app/core/utils/toast_message.dart';
import 'package:bakery_app/features/data/models/bread_price.dart';
import 'package:bakery_app/features/data/models/dough_product_process.dart';
import 'package:bakery_app/features/presentation/pages/admin/bloc/bread_price/bread_price_bloc.dart';
import 'package:bakery_app/features/presentation/pages/admin/bloc/dough_products_process/dough_products_process_bloc.dart';
import 'package:bakery_app/features/presentation/widgets/custom_product_process_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/global_variables.dart';
import '../../../../data/models/product_process.dart';
import '../../../widgets/empty_content.dart';
import '../../../widgets/error_animation.dart';
import '../../../widgets/loading_indicator.dart';
import '../bloc/products_process/products_process_bloc.dart';

class ProductsProcessPage extends StatefulWidget {
  static const String routeName = "products-process-page";
  const ProductsProcessPage({super.key});

  @override
  State<ProductsProcessPage> createState() => _ProductsProcessPageState();
}

class _ProductsProcessPageState extends State<ProductsProcessPage> {
  int index = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFloatingButton(),
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: GroupButton(
              isRadio: true,
              onSelected: (text, indx, isSelected) {
                setState(() {
                  index = indx;
                });
              },
              buttons: const [
                'hamurhane',
                'Pastane',
                'Börek',
                'Dışardan alınan'
              ],
              options: const GroupButtonOptions(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  groupingType: GroupingType.row,
                  direction: Axis.horizontal,
                  selectedColor: GlobalVariables.secondaryColor,
                  unselectedColor: GlobalVariables.secondaryColorLight),
            ),
          ),
        ),
        _setBodyContent()
      ],
    );
  }

  _buildFloatingButton() {
    if (index != -1) {
      return FloatingActionButton(
        onPressed: () {
          if (index == 0) {
            _addDoughProductDialog();
            return;
          }
          _addProductDialog();
        },
        backgroundColor: GlobalVariables.secondaryColor,
        tooltip: 'Add Dough List',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      );
    }
    return null;
  }

  Widget _setBodyContent() {
    switch (index) {
      case 0:
        return _getDoughFactoryProducts();
      case 1:
        return _getProductsByCategory(1);
      case 2:
        return _getProductsByCategory(2);
      case 3:
        return _getProductsByCategory(3);
    }
    return Center(
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Lottie.asset('assets/select_animation.json',
            repeat: true, animate: true),
      ),
    );
  }

  _addDoughProductDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomProductProcessDialog(
              title: 'Ürün ekleme',
              nameController: TextEditingController(),
              numberController: TextEditingController(),
              numberLabel: 'Ekmek dengi',
              onSave: (status, name, number) {
                context.read<DoughProductsProcessBloc>().add(
                    AddDoughProductRequested(
                        product: DoughProductProcessModel(
                            id: 0,
                            name: name,
                            breadEquivalent: number,
                            status: status)));
              },
              status: true);
        });
  }

  _addProductDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomProductProcessDialog(
              title: 'Ürün ekleme',
              nameController: TextEditingController(),
              numberController: TextEditingController(),
              numberLabel: 'Fiyat',
              onSave: (status, name, number) {
                context.read<ProductsProcessBloc>().add(AddProductRequested(
                    product: ProductProcessModel(
                        id: 0,
                        name: name,
                        price: number,
                        status: status,
                        categoryId: index),
                    categoryId: index));
              },
              status: true);
        });
  }

  _updateDoughProductDialog(DoughProductProcessModel product) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomProductProcessDialog(
              title: 'Ürün güncelleme',
              nameController: TextEditingController(text: product.name),
              numberController: TextEditingController(
                  text: product.breadEquivalent.toString()),
              numberLabel: 'Ekmek dengi',
              onSave: (status, name, number) {
                if (status == product.status &&
                    name == product.name &&
                    number == product.breadEquivalent) {
                  return;
                }
                context.read<DoughProductsProcessBloc>().add(
                    UpdateDoughProductRequested(
                        product: DoughProductProcessModel(
                            id: product.id,
                            name: name,
                            breadEquivalent: number,
                            status: status)));
              },
              status: product.status);
        });
  }

  _updateProductDialog(ProductProcessModel product) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomProductProcessDialog(
              title: 'Ürün güncelleme',
              nameController: TextEditingController(text: product.name),
              numberController:
                  TextEditingController(text: product.price.toString()),
              numberLabel: 'Fiyat',
              onSave: (status, name, number) {
                if (status == product.status &&
                    name == product.name &&
                    number == product.price) {
                  return;
                }
                context.read<ProductsProcessBloc>().add(UpdateProductRequested(
                      product: ProductProcessModel(
                          id: product.id,
                          name: name,
                          price: number,
                          status: status,
                          categoryId: product.categoryId),
                    ));
              },
              status: product.status);
        });
  }

  _getDoughFactoryProducts() {
    context.read<DoughProductsProcessBloc>().add(GetDoughProductsRequested());
    return BlocBuilder<DoughProductsProcessBloc, DoughProductsProcessState>(
        builder: ((context, state) {
      return switch (state) {
        DoughProductsProcessLoading() => const LoadingIndicator(),
        DoughProductsProcessFailure() => const ErrorAnimation(),
        DoughProductsProcessSuccess() => state.doughProductsProcessList!.isEmpty
            ? const EmptyContent()
            : Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: ListView.builder(
                    itemCount: state.doughProductsProcessList!.length,
                    itemBuilder: (context, index) {
                      return Material(
                        child: ListTile(
                          tileColor: index.isOdd
                              ? GlobalVariables.oddItemColor
                              : GlobalVariables.evenItemColor,
                          title:
                              Text(state.doughProductsProcessList![index].name),
                          subtitle: Text(
                              "Ekmek dengi: ${state.doughProductsProcessList![index].breadEquivalent}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  _updateDoughProductDialog(
                                      state.doughProductsProcessList![index]);
                                },
                                icon: const Icon(Icons.edit),
                                color: GlobalVariables.secondaryColor,
                              ),
                              Icon(
                                Icons.circle,
                                color: state
                                        .doughProductsProcessList![index].status
                                    ? Colors.green
                                    : Colors.red,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
      };
    }));
  }

  _getProductsByCategory(int categoryId) {
    context.read<ProductsProcessBloc>().add(GetProductsRequested(categoryId));
    return BlocBuilder<ProductsProcessBloc, ProductsProcessState>(
        builder: ((context, state) {
      return switch (state) {
        ProductsProcessLoading() => const LoadingIndicator(),
        ProductsProcessFailure() => const ErrorAnimation(),
        ProductsProcessSuccess() => state.productsProcessList!.isEmpty
            ? const EmptyContent()
            : Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: ListView.builder(
                    itemCount: state.productsProcessList!.length,
                    itemBuilder: (context, index) {
                      return Material(
                        child: ListTile(
                          tileColor: index.isOdd
                              ? GlobalVariables.oddItemColor
                              : GlobalVariables.evenItemColor,
                          title: Text(state.productsProcessList![index].name),
                          subtitle: Text(
                              "Fiyat: ${state.productsProcessList![index].price}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  _updateProductDialog(
                                      state.productsProcessList![index]);
                                },
                                icon: const Icon(Icons.edit),
                                color: GlobalVariables.secondaryColor,
                              ),
                              Icon(
                                Icons.circle,
                                color: state.productsProcessList![index].status
                                    ? Colors.green
                                    : Colors.red,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
      };
    }));
  }

  _buildAppbar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      title: const Text(
        "Fırın Ürünler",
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        PopupMenuButton<String>(
          color: Colors.white,
          itemBuilder: (context) {
            List<PopupMenuItem<String>> items = [];
            items.add(const PopupMenuItem<String>(
              value: 'bread-price',
              child: Text('Ekmek Fiyati'),
            ));
            return items;
          },
          onSelected: (value) {
            if (value == 'bread-price') {
              _showBreadPrices();
            }
          },
        ),
      ],
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      backgroundColor: GlobalVariables.secondaryColor,
      centerTitle: true,
    );
  }

  _showBreadPrices() {
    context.read<BreadPriceBloc>().add(GetBreadPriceRequested());
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<BreadPriceBloc, BreadPriceState>(
              builder: ((context, state) {
            return switch (state) {
              BreadPriceLoading() => const LoadingIndicator(),
              BreadPriceFailure() => const ErrorAnimation(),
              BreadPriceSuccess() => state.breadPriceList!.isEmpty
                  ? const EmptyContent()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Ekmek Fiyatı",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                CircleAvatar(
                                  backgroundColor:
                                      GlobalVariables.secondaryColorLight,
                                  child: IconButton(
                                    onPressed: () {
                                      _breadPriceDialog(null);
                                    },
                                    icon: const Icon(Icons.add),
                                    color: GlobalVariables.secondaryColor,
                                  ),
                                )
                              ]),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.breadPriceList!.length,
                            itemBuilder: (context, index) {
                              return Material(
                                child: ListTile(
                                  tileColor: index.isOdd
                                      ? GlobalVariables.oddItemColor
                                      : GlobalVariables.evenItemColor,
                                  title: Text(state.breadPriceList![index].price
                                      .toString()),
                                  subtitle: Text(getFormattedDateTime(
                                      state.breadPriceList![index].date)),
                                  trailing: index == 0
                                      ? IconButton(
                                          onPressed: () {
                                            _breadPriceDialog(
                                                state.breadPriceList![index]);
                                          },
                                          icon: const Icon(Icons.edit),
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

  void _breadPriceDialog(BreadPriceModel? breadPriceModel) {
    TextEditingController priceController = TextEditingController();
    if (breadPriceModel != null) {
      priceController.text = breadPriceModel.price.toString();
    }
    String title =
        breadPriceModel != null ? "Fiyat Güncelleme" : "Yeni Fiyat Ekleme";
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: TextField(
              controller: priceController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
              ],
              decoration: const InputDecoration(labelText: 'Tutar'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Vazgeç'),
              ),
              TextButton(
                onPressed: () {
                  double price = double.tryParse(priceController.text) ?? 0.0;
                  if (price > 0) {
                    if (breadPriceModel == null) {
                      context.read<BreadPriceBloc>().add(AddBreadPriceRequested(
                          breadPrice: BreadPriceModel(
                              id: 0, date: DateTime.now(), price: price)));
                    } else {
                      context.read<BreadPriceBloc>().add(
                          UpdateBreadPriceRequested(
                              breadPrice: BreadPriceModel(
                                  id: breadPriceModel.id,
                                  date: breadPriceModel.date,
                                  price: price)));
                    }
                    Navigator.of(context).pop();
                    return;
                  }
                  showToastMessage('Geçerli bir fiyat giriniz');
                },
                child: const Text('Kaydet'),
              ),
            ],
          );
        });
  }
}

import 'package:bakery_app/features/data/models/service_added_market.dart';
import 'package:bakery_app/features/data/models/service_market.dart';
import 'package:bakery_app/features/data/models/service_market_to_add.dart';
import 'package:bakery_app/features/presentation/pages/service/bloc/service_added_markets/service_added_markets_bloc.dart';
import 'package:bakery_app/features/presentation/pages/service/bloc/service_markets/service_markets_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/toast_message.dart';

import '../../../widgets/added_product.dart';
import '../../../widgets/available_product.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_confirmation_dialog.dart';
import '../../../widgets/custom_save_button.dart';
import '../../../widgets/custom_update_quantity_dialog.dart';
import '../../../widgets/editable_added_product.dart';
import '../../../widgets/empty_content.dart';
import '../../../widgets/error_animation.dart';
import '../../../widgets/loading_indicator.dart';

class ServiceMarketsPage extends StatelessWidget {
  static const String routeName = "service-markets-page";
  final bool canEdit;
  int listId;
  final int userId;
  ServiceMarketsPage({super.key, required this.canEdit, required this.listId, required this.userId});
  List<ServiceMarketToAddModel> listToPost = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          title: "Servis Dağıtımı",
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
              child: _getAvailableMarkets(context),
            ),
            SizedBox(
              height: sectionHeight,
              child: _getEditableGivenMarkets(context),
            ),
            SizedBox(
              width: double.infinity,
              height: buttonHeight,
              child: CustomSaveButton(
                onTap: () {
                  _saveNewMarkets(context);
                },
                text: "Kaydet",
              ),
            ),
          ],
        );
      });
    } else {
      return _getGivenMarkets(context);
    }
  }

  _getGivenMarkets(BuildContext context) {
    context
        .read<ServiceAddedMarketsBloc>()
        .add(ServiceGetAddedMarketsRequested(listId: listId));
    return BlocBuilder<ServiceAddedMarketsBloc, ServiceAddedMarketsState>(
        builder: ((context, state) {
      return switch (state) {
        ServiceAddedMarketsLoading() => const LoadingIndicator(),
        ServiceAddedMarketsFailure() => const ErrorAnimation(),
        ServiceAddedMarketsSuccess() => state.serviceAddedMarkets!.isEmpty
            ? const EmptyContent()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        "Verilen Marketler",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.serviceAddedMarkets!.length,
                      itemBuilder: (context, index) {
                        return AddedProduct(
                            productName:
                                state.serviceAddedMarkets![index].marketName!,
                            quantity:
                                state.serviceAddedMarkets![index].quantity!,
                            index: index);
                      },
                    ),
                  ),
                ],
              )
      };
    }));
  }

  _getEditableGivenMarkets(BuildContext context) {
    context
        .read<ServiceAddedMarketsBloc>()
        .add(ServiceGetAddedMarketsRequested(listId: listId));
    return BlocBuilder<ServiceAddedMarketsBloc, ServiceAddedMarketsState>(
        builder: ((context, state) {
      if (state is ServiceAddedMarketsSuccess &&
          state.listId != null &&
          state.listId != 0) {
        listId = state.listId!;
      }
      return switch (state) {
        ServiceAddedMarketsLoading() => const LoadingIndicator(),
        ServiceAddedMarketsFailure() => const ErrorAnimation(),
        ServiceAddedMarketsSuccess() => state.serviceAddedMarkets!.isEmpty
            ? const EmptyContent()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        "Verilen Marketler",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.serviceAddedMarkets!.length,
                      itemBuilder: (context, index) {
                        return EditableAddedProduct(
                            productName:
                                state.serviceAddedMarkets![index].marketName!,
                            quantity:
                                state.serviceAddedMarkets![index].quantity!,
                            onEditPressed: () {
                              _updateAddedProduct(context,
                                  state.serviceAddedMarkets![index], index);
                            },
                            onDeletePressed: () {
                              _removeAddedProduct(
                                  context, state.serviceAddedMarkets![index]);
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

  _getAvailableMarkets(BuildContext context) {
    List<TextEditingController> controllers = List.empty(growable: true);
    context
        .read<ServiceMarketsBloc>()
        .add(ServiceGetMarketsRequested(listId: listId));

    return BlocBuilder<ServiceMarketsBloc, ServiceMarketsState>(
        builder: ((context, state) {
      return switch (state) {
        ServiceMarketsLoading() => const LoadingIndicator(),
        ServiceMarketsFailure() => const ErrorAnimation(),
        ServiceMarketsSuccess() => state.markets!.isEmpty
            ? const EmptyContent()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(8),
                    child: const Center(
                      child: Text(
                        "Marketler Listsi",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.markets!.length,
                      itemBuilder: (context, index) {
                        controllers.add(TextEditingController());
                        return AvailableProductWidget(
                            productName: state.markets![index].name!,
                            controller: controllers[index],
                            index: index,
                            onPressed: () {
                              if (controllers[index].text.isNotEmpty &&
                                  controllers[index].text != "0") {
                                _addProductToAddedList(
                                    context,
                                    state.markets![index],
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

  _removeAddedProduct(
      BuildContext context, ServiceAddedMarketModel addedMarket) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomConfirmationDialog(
              title: 'Silme',
              content:
                  '${addedMarket.marketName}\'in verilen servisi silmek için emin misiniz?',
              onTap: () {
                if (listToPost.isNotEmpty) {
                  listToPost.removeWhere(
                      (element) => element.marketId == addedMarket.marketId);
                }
                context.read<ServiceAddedMarketsBloc>().add(
                    ServiceRemoveAddedMarketRequested(market: addedMarket));
                context.read<ServiceMarketsBloc>().add(
                    ServiceAddMarketRequested(
                        market: ServiceMarketModel(
                            id: addedMarket.marketId,
                            name: addedMarket.marketName)));
              });
        });
  }

  _addProductToAddedList(
      BuildContext context, ServiceMarketModel marketModel, int quantity) {
    // bloc second
    context
        .read<ServiceMarketsBloc>()
        .add(ServiceRemoveMarketRequested(market: marketModel));
    context.read<ServiceAddedMarketsBloc>().add(ServiceAddAddedMarketRequested(
        market: ServiceAddedMarketModel(
            id: 0,
            serviceListId: listId,
            marketId: marketModel.id,
            marketName: marketModel.name,
            quantity: quantity)));

    listToPost.add(ServiceMarketToAddModel(
        marketId: marketModel.id, serviceListId: listId, quantity: quantity));
  }

  _saveNewMarkets(BuildContext context) async {
    if (listToPost.isNotEmpty) {
    
        context.read<ServiceAddedMarketsBloc>().add(
            ServicePostAddedMarketRequested(
                markets: listToPost, userId: userId));
      
    } else {
      showToastMessage("Yeni ürün eklemelisiniz!");
    }
  }

  _updateAddedProduct(BuildContext context,
      ServiceAddedMarketModel addedMarketModel, int index) {
    TextEditingController controller =
        TextEditingController(text: addedMarketModel.quantity.toString());
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return UpdateQuantityDialog(
            controller: controller,
            onSave: (newQuantity) {
              if (newQuantity == addedMarketModel.quantity) {
                return;
              }
              if (addedMarketModel.id == 0 && listToPost.isNotEmpty) {
                int indexToUpdate = listToPost.indexWhere(
                    (element) => element.marketId == addedMarketModel.marketId);

                if (indexToUpdate != -1) {
                  // Check if the item is found in the list
                  ServiceMarketToAddModel updatedMarket =
                      ServiceMarketToAddModel(
                    serviceListId: listToPost[indexToUpdate].serviceListId,
                    quantity: newQuantity,
                    marketId: listToPost[indexToUpdate].marketId,
                  );

                  listToPost[indexToUpdate] = updatedMarket;
                }
              }
              context.read<ServiceAddedMarketsBloc>().add(
                  ServiceUpdateAddedMarketRequested(
                      market: ServiceAddedMarketModel(
                          id: addedMarketModel.id,
                          serviceListId: listId,
                          marketId: addedMarketModel.marketId,
                          marketName: addedMarketModel.marketName,
                          quantity: newQuantity),
                      index: index));
            },
            title: "Güncelleme",
            content:
                "${addedMarketModel.marketName} market'e verilen ekmek adedini güncellemek için emin misiniz?",
          );
        });
  }
}

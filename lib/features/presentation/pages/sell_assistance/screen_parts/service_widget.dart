import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/global_variables.dart';
import '../../../../../core/utils/toast_message.dart';
import '../../../../data/models/given_product_to_service.dart';
import '../../../../data/models/received_money_from_service.dart';
import '../../../../data/models/service_stale_product.dart';
import '../../../widgets/custom_confirmation_dialog.dart';
import '../../../widgets/custom_payment_dialog.dart';
import '../../../widgets/custom_receive_amount_dialog.dart';
import '../../../widgets/custom_sell_list_tile.dart';
import '../../../widgets/empty_content.dart';
import '../../../widgets/error_animation.dart';
import '../../../widgets/loading_indicator.dart';
import '../bloc/given_product_to_service/given_product_to_service_bloc.dart';
import '../bloc/received_money_from_service/received_money_from_service_bloc.dart';
import '../bloc/service_stale_product/service_stale_product_bloc.dart';

class ServiceWidget extends StatelessWidget {
  final DateTime selectedDate;
  final bool isAdmin;
  final int userId;
  final bool todayDate;
  const ServiceWidget(
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
          'Service',
        ),
        children: [
          CustomSellListTile(
              title: 'Şoför',
              onShowDetails: () {
                _showGivenProductToServiceList(1,context);
              },
              onAdd: todayDate || isAdmin
                  ? () => _addGivenProductToService(1,context)
                  : null),
          const Divider(
            height: 1,
            color: Colors.white,
            indent: 10,
            endIndent: 10,
          ),
          CustomSellListTile(
              title: 'Getir',
              onShowDetails: () => _showGivenProductToServiceList(2,context),
              onAdd: todayDate || isAdmin
                  ? () => _addGivenProductToService(2,context)
                  : null),
          const Divider(
            height: 1,
            color: Colors.white,
            indent: 10,
            endIndent: 10,
          ),
          CustomSellListTile(
              title: 'Alınan Bayat',
              onShowDetails: () {
                _showServiceStaleProductList(context);
              },
              onAdd: todayDate || isAdmin
                  ? () {
                      _addServiceStaleProduct(context);
                    }
                  : null),
          const Divider(
            height: 1,
            color: Colors.white,
            indent: 10,
            endIndent: 10,
          ),
          CustomSellListTile(
              title: 'Alınan Para',
              onShowDetails: () {
                _updateReceivedPaymentFromService(1,
                    "Servisten alınan parayı güncellemek için emin misiniz?",context)                ;
              },
              onAdd: todayDate || isAdmin
                  ? () {
                      _addReceivedPaymentFromServiceDialog(
                          1, "Servisten alınan para",context);
                    }
                  : null)
        ],
      ),
    );
  }

  _showGivenProductToServiceList(int serviceType, BuildContext context) {
    context.read<GivenProductToServiceBloc>().add(
        GivenProductToServiceGetListRequested(
            date: selectedDate, servisTypeId: serviceType));
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<GivenProductToServiceBloc,
              GivenProductToServiceState>(builder: ((context, state) {
            return switch (state) {
              GivenProductToServiceLoading() => const LoadingIndicator(),
              GivenProductToServiceFailure() => const ErrorAnimation(),
              GivenProductToServiceSuccess() => state
                      .givenProductToServiceList!.isEmpty
                  ? const EmptyContent()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: Text(
                              "Ekmek Teslimat Listesi",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.givenProductToServiceList!.length,
                            itemBuilder: (context, index) {
                              return Material(
                                child: ListTile(
                                  tileColor: index.isOdd
                                      ? GlobalVariables.oddItemColor
                                      : GlobalVariables.evenItemColor,
                                  title: Text(state
                                      .givenProductToServiceList![index]
                                      .quantity
                                      .toString()),
                                  subtitle: Text(getFormattedDateTime(state
                                      .givenProductToServiceList![index].date)),
                                  trailing: (todayDate &&
                                              userId ==
                                                  state
                                                      .givenProductToServiceList![
                                                          index]
                                                      .userId) ||
                                          isAdmin
                                      ? Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                              IconButton(
                                                  onPressed: () {
                                                    _updateGivenProductToService(
                                                        state.givenProductToServiceList![
                                                            index],
                                                        context);
                                                  },
                                                  icon: const Icon(Icons.edit),
                                                  color: GlobalVariables
                                                      .secondaryColor),
                                              IconButton(
                                                  onPressed: () {
                                                    _deleteGivenProductToService(
                                                        state.givenProductToServiceList![
                                                            index],
                                                        context);
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

  _addGivenProductToService(int serviceType, BuildContext context) {
    TextEditingController controller = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomReceiveAmountDialog(
              title: 'Ekmek Teslimati',
              controller: controller,
              onSave: (amount) {
                context.read<GivenProductToServiceBloc>().add(
                    GivenProductToServicePostRequested(
                        givenProductToService: GivenProductToServiceModel(
                            id: 0,
                            userId: userId,
                            quantity: amount,
                            date: DateTime.now(),
                            serviceProductId: 1,
                            serviceTypeId: serviceType)));
              });
        });
  }

  _updateGivenProductToService(
      GivenProductToServiceModel givenProductToServiceModel,
      BuildContext context) {
    TextEditingController controller = TextEditingController(
        text: givenProductToServiceModel.quantity.toString());

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomReceiveAmountDialog(
              title: 'Ekmek Teslimati Güncelleme',
              controller: controller,
              onSave: (amount) {
                if (amount == givenProductToServiceModel.quantity) {
                  return;
                }
                context.read<GivenProductToServiceBloc>().add(
                    GivenProductToServiceUpdateRequested(
                        givenProductToService: GivenProductToServiceModel(
                            id: givenProductToServiceModel.id,
                            userId: givenProductToServiceModel.userId,
                            quantity: amount,
                            date: givenProductToServiceModel.date,
                            serviceProductId:
                                givenProductToServiceModel.serviceProductId,
                            serviceTypeId:
                                givenProductToServiceModel.serviceTypeId)));
              });
        });
  }

  _deleteGivenProductToService(
      GivenProductToServiceModel givenProductToServiceModel,
      BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomConfirmationDialog(
              title: 'Silme',
              content: 'Ekmek teslimati silmek için emin misiniz?',
              onTap: () {
                context.read<GivenProductToServiceBloc>().add(
                    GivenProductToServiceDeleteRequested(
                        givenProductToService: givenProductToServiceModel));
              });
        });
  }

  _showServiceStaleProductList(BuildContext context) {
    context.read<ServiceStaleProductBloc>().add(
        ServiceStaleProductGetListRequested(
            date: selectedDate, serviceTypeId: 1));
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<ServiceStaleProductBloc, ServiceStaleProductState>(
              builder: ((context, state) {
            return switch (state) {
              ServiceStaleProductLoading() => const LoadingIndicator(),
              ServiceStaleProductFailure() => const ErrorAnimation(),
              ServiceStaleProductSuccess() => state
                      .serviceStaleProductList!.isEmpty
                  ? const EmptyContent()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: Text(
                              "Alınan Bayat Listesi",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.serviceStaleProductList!.length,
                            itemBuilder: (context, index) {
                              return Material(
                                child: ListTile(
                                  tileColor: index.isOdd
                                      ? GlobalVariables.oddItemColor
                                      : GlobalVariables.evenItemColor,
                                  title: Text(state
                                      .serviceStaleProductList![index].quantity
                                      .toString()),
                                  subtitle: Text(getFormattedDateTime(state
                                      .serviceStaleProductList![index].date)),
                                  trailing: (todayDate &&
                                              userId ==
                                                  state
                                                      .serviceStaleProductList![
                                                          index]
                                                      .userId) ||
                                          isAdmin
                                      ? Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                              IconButton(
                                                  onPressed: () {
                                                    _updateServiceStaleProduct(
                                                        state.serviceStaleProductList![
                                                            index],
                                                        context);
                                                  },
                                                  icon: const Icon(Icons.edit),
                                                  color: GlobalVariables
                                                      .secondaryColor),
                                              IconButton(
                                                  onPressed: () {
                                                    _deleteServiceStaleProduct(
                                                        state.serviceStaleProductList![
                                                            index],
                                                        context);
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

  _deleteServiceStaleProduct(
      ServiceStaleProductModel serviceStaleProduct, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomConfirmationDialog(
              title: 'Silme',
              content: 'Alınan bayatı silmek için emin misiniz?',
              onTap: () {
                context.read<ServiceStaleProductBloc>().add(
                    ServiceStaleProductDeleteRequested(
                        serviceStaleProduct: serviceStaleProduct));
              });
        });
  }

  _updateServiceStaleProduct(
      ServiceStaleProductModel serviceStaleProduct, BuildContext context) {
    TextEditingController controller =
        TextEditingController(text: serviceStaleProduct.quantity.toString());

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomReceiveAmountDialog(
              title: 'Ekmek Teslimati Güncelleme',
              controller: controller,
              onSave: (amount) {
                if (amount == serviceStaleProduct.quantity) {
                  return;
                }
                context.read<ServiceStaleProductBloc>().add(
                    ServiceStaleProductUpdateRequested(
                        serviceStaleProduct: ServiceStaleProductModel(
                            id: serviceStaleProduct.id,
                            userId: serviceStaleProduct.userId,
                            quantity: amount,
                            date: serviceStaleProduct.date,
                            serviceProductId:
                                serviceStaleProduct.serviceProductId,
                            serviceTypeId: serviceStaleProduct.serviceTypeId)));
              });
        });
  }

  _addServiceStaleProduct(BuildContext context) {
    TextEditingController controller = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomReceiveAmountDialog(
              title: 'Teslim Alınan Bayat',
              controller: controller,
              onSave: (amount) {
                context.read<ServiceStaleProductBloc>().add(
                      ServiceStaleProductPostRequested(
                        serviceStaleProduct: ServiceStaleProductModel(
                            id: 0,
                            userId: userId,
                            quantity: amount,
                            date: DateTime.now(),
                            serviceProductId: 1,
                            serviceTypeId: 1),
                      ),
                    );
              });
        });
  }

  _addReceivedPaymentFromServiceDialog(
      int serviceTypeId, String title, BuildContext context) {
    context.read<ReceivedMoneyFromServiceBloc>().add(
        ReceivedMoneyFromServiceGetListRequested(
            date: selectedDate, servisTypeId: serviceTypeId));
    TextEditingController controller = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<ReceivedMoneyFromServiceBloc,
              ReceivedMoneyFromServiceState>(builder: ((context, state) {
            return switch (state) {
              ReceivedMoneyFromServiceLoading() => const LoadingIndicator(),
              ReceivedMoneyFromServiceFailure() => const ErrorAnimation(),
              ReceivedMoneyFromServiceSuccess() =>
                state.receivedMoneyFromService != null
                    ? CustomConfirmationDialog(
                        title: "Uyarı",
                        onTap: () {},
                        content: "Servisten para teslim alınmış")
                    : CustomPaymentDialog(
                        title: title,
                        controller: controller,
                        onSave: (paidAmount) {
                          if (paidAmount < 1) {
                            showToastMessage("Geçerli bir tutar girilmeli!");
                            return;
                          }
                          context.read<ReceivedMoneyFromServiceBloc>().add(
                              ReceivedMoneyFromServicePostRequested(
                                  receivedMoneyFromService:
                                      ReceivedMoneyFromServiceModel(
                                          id: 0,
                                          userId: userId,
                                          amount: paidAmount,
                                          serviceTypeId: serviceTypeId,
                                          date: selectedDate)));
                        })
            };
          }));
        });
  }

  _updateReceivedPaymentFromService(
      int serviceTypeId, String title, BuildContext context) {
    context.read<ReceivedMoneyFromServiceBloc>().add(
        ReceivedMoneyFromServiceGetListRequested(
            date: selectedDate, servisTypeId: serviceTypeId));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<ReceivedMoneyFromServiceBloc,
              ReceivedMoneyFromServiceState>(builder: ((context, state) {
            return switch (state) {
              ReceivedMoneyFromServiceLoading() => const LoadingIndicator(),
              ReceivedMoneyFromServiceFailure() => const ErrorAnimation(),
              ReceivedMoneyFromServiceSuccess() => state
                          .receivedMoneyFromService ==
                      null
                  ? CustomConfirmationDialog(
                      title: "Uyarı",
                      onTap: () {},
                      content: "Para teslimatı daha yapılmadı")
                  : CustomPaymentDialog(
                      title: "Güncelleme",
                      firstText: title,
                      controller: TextEditingController(
                          text: state.receivedMoneyFromService!.amount
                              .toString()),
                      onSave: (paidAmount) {
                        if (paidAmount < 1) {
                          showToastMessage("Geçerli bir tutar girilmeli!");
                          return;
                        }
                        if (paidAmount ==
                            state.receivedMoneyFromService!.amount) {
                          return;
                        }
                        context.read<ReceivedMoneyFromServiceBloc>().add(
                            ReceivedMoneyFromServiceUpdateRequested(
                                receivedMoneyFromService:
                                    ReceivedMoneyFromServiceModel(
                                        id: state.receivedMoneyFromService!.id,
                                        userId: state
                                            .receivedMoneyFromService!.userId,
                                        amount: paidAmount,
                                        serviceTypeId: state
                                            .receivedMoneyFromService!
                                            .serviceTypeId,
                                        date: state
                                            .receivedMoneyFromService!.date)));
                      })
            };
          }));
        });
  }
}

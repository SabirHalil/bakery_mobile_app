import 'package:bakery_app/features/data/models/service_debt_detail.dart';
import 'package:bakery_app/features/data/models/service_debt_total.dart';
import 'package:bakery_app/features/presentation/pages/service/bloc/service_debt/service_debt_bloc.dart';
import 'package:bakery_app/features/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/global_variables.dart';
import '../../../../../core/utils/is_today_check.dart';
import '../../../../../core/utils/toast_message.dart';
import '../../../widgets/custom_confirmation_dialog.dart';
import '../../../widgets/custom_payment_dialog.dart';
import '../../../widgets/empty_content.dart';
import '../../../widgets/error_animation.dart';
import '../../../widgets/loading_indicator.dart';
import '../bloc/service_debt_detail/service_debt_detail_bloc.dart';

class ServiceDebtPage extends StatelessWidget {
  static const String routeName = "service-debt-page";
  const ServiceDebtPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: 'Servis Borçları', onTap: () => Navigator.pop(context)),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    context.read<ServiceDebtBloc>().add(ServiceGetTotalDebtList());
    return BlocBuilder<ServiceDebtBloc, ServiceDebtState>(
        builder: ((context, state) {
      
      return switch (state) {
        ServiceDebtLoading() => const LoadingIndicator(),
        ServiceDebtFailure() => const ErrorAnimation(),
        ServiceTotalDebtSuccess() => state.serviceTotalDebtList!.isEmpty
            ? const EmptyContent()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        "Borçlu Marketler",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.serviceTotalDebtList!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          tileColor: index.isOdd
                              ? GlobalVariables.oddItemColor
                              : GlobalVariables.evenItemColor,
                          title: Text(
                              state.serviceTotalDebtList![index].marketName),
                          trailing:
                              Row(mainAxisSize: MainAxisSize.min, children: [
                            Text(
                              '${state.serviceTotalDebtList![index].amount}₺',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  _showDebtDetails(context,
                                      state.serviceTotalDebtList![index]);
                                },
                                icon: const Icon(Icons.menu),
                                color: GlobalVariables.secondaryColor),
                            if (state.serviceTotalDebtList![index].amount != 0)
                              IconButton(
                                  onPressed: () {
                                    _showPayDebtDialog(context,
                                        state.serviceTotalDebtList![index]);
                                  },
                                  icon: const Icon(Icons.money),
                                  color: GlobalVariables.secondaryColor)
                          ]),
                        );
                      },
                    ),
                  ),
                ],
              )
      };
    }));
  }

  void _showDebtDetails(
      BuildContext context, ServiceDebtTotalModel serviceDebtTotalModel) {
    context.read<ServiceDebtDetailBloc>().add(
        ServiceGetDebtDetailList(marketId: serviceDebtTotalModel.marketId));
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<ServiceDebtDetailBloc, ServiceDebtDetailState>(
              builder: ((context, state) {
        
            return switch (state) {
              ServiceDebtDetailLoading() => const LoadingIndicator(),
              ServiceDebtDetailFailure() => const ErrorAnimation(),
              ServiceDebtDetailSuccess() => state.serviceDebtDetailList!.isEmpty
                  ? const EmptyContent()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Center(
                            child: Text(
                              "${serviceDebtTotalModel.marketName} Borç Geçmişi",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.serviceDebtDetailList!.length,
                            itemBuilder: (context, index) {
                              return Material(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: state
                                            .serviceDebtDetailList![index]
                                            .amount
                                            .isNegative
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  tileColor: index.isOdd
                                      ? GlobalVariables.oddItemColor
                                      : GlobalVariables.evenItemColor,
                                  title: Text(state
                                      .serviceDebtDetailList![index].amount
                                      .toString()),
                                  subtitle: Text(getFormattedDateTime(
                                      state.serviceDebtDetailList![index].date)),
                                  trailing: isToday(state
                                          .serviceDebtDetailList![index].date)
                                      ? Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                              IconButton(
                                                  onPressed: () {
                                                    _updatePaidDebt(
                                                        context,
                                                        state.serviceDebtDetailList![
                                                            index],
                                                        serviceDebtTotalModel
                                                            .amount);
                                                  },
                                                  icon: const Icon(Icons.edit),
                                                  color: GlobalVariables
                                                      .secondaryColor),
                                              IconButton(
                                                  onPressed: () {
                                                    _deletePaidDebt(
                                                        context,
                                                        state.serviceDebtDetailList![
                                                            index],
                                                        serviceDebtTotalModel
                                                            .marketName);
                                                  },
                                                  icon: const Icon(Icons.delete),
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

  void _showPayDebtDialog(
      BuildContext context, ServiceDebtTotalModel serviceDebtTotalModel) {
    TextEditingController controller =
        TextEditingController(text: serviceDebtTotalModel.amount.toString());

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomPaymentDialog(
              title: 'Borç öde',
              firstText:
                  ('${serviceDebtTotalModel.marketName} marketin toplam borcu ${serviceDebtTotalModel.amount}₺'),
              controller: controller,
              onSave: (paidAmount) async {
                if (paidAmount > serviceDebtTotalModel.amount) {
                  showToastMessage("Borçtan fazla ödeme yapılmaz!");
                  return;
                }
                if (paidAmount == 0) {
                  showToastMessage("Geçerli bir sayı girmelisiniz!");
                  return;
                }
                context.read<ServiceDebtBloc>().add(ServicePostDebtPayment(
                    serviceDebtDetail: ServiceDebtDetailModel(
                        id: 0,
                        marketId: serviceDebtTotalModel.marketId,
                        date: DateTime.now(),
                        amount: paidAmount)));
              });
        });
  }


  void _deletePaidDebt(BuildContext context,
      ServiceDebtDetailModel serviceDebtDetailModel, String marketName) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomConfirmationDialog(
              title: 'Silme',
              content:
                  '$marketName market\'in borç ödemesini silmek için emin misiniz?',
              onTap: () {
                context.read<ServiceDebtDetailBloc>().add(
                    ServiceDeleteDebtPayment(
                        context: context,
                        serviceDebtDetail: serviceDebtDetailModel));
              });
        });
  }

  void _updatePaidDebt(BuildContext context,
      ServiceDebtDetailModel serviceDebtDetailModel, double totalDebt) {
    TextEditingController controller =
        TextEditingController(text: serviceDebtDetailModel.amount.abs().toString());
    
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomPaymentDialog(
              controller: controller,
              firstText: 'Alınan parayı güncellemek için emin misin?}',
              onSave: (newAmount) {
                if (newAmount > (totalDebt + serviceDebtDetailModel.amount.abs())) {
                  showToastMessage("Toplam borçtan fazla ödenmez!");
                  return;
                }
                if (newAmount == 0) {
                  showToastMessage("Geçerli bir sayı girmelisiniz!");
                  return;
                }
                if (newAmount != serviceDebtDetailModel.amount) {
                  context.read<ServiceDebtDetailBloc>().add(
                      ServiceUpdateDebtPayment(
                          context: context,
                          serviceDebtDetail: ServiceDebtDetailModel(
                              id: serviceDebtDetailModel.id,
                              marketId: serviceDebtDetailModel.marketId,
                              date: serviceDebtDetailModel.date,
                              amount: newAmount)));
                }
              },
              title: 'Güncelleme');
        });
  }
}

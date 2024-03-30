import 'package:bakery_app/core/utils/toast_message.dart';
import 'package:bakery_app/features/data/models/system_time.dart';
import 'package:bakery_app/features/presentation/pages/admin/bloc/pdf/pdf_bloc.dart';
import 'package:bakery_app/features/presentation/pages/admin/bloc/system_time/system_time_bloc.dart';
import 'package:bakery_app/features/presentation/pages/admin/screens/markets_process_page.dart';
import 'package:bakery_app/features/presentation/pages/admin/screens/pdf_view_page.dart';
import 'package:bakery_app/features/presentation/pages/admin/screens/products_process_page.dart';
import 'package:bakery_app/features/presentation/pages/dough/screens/dough_list_page.dart';
import 'package:bakery_app/features/presentation/pages/production/screens/production_page.dart';
import 'package:bakery_app/features/presentation/pages/service/screens/service_lists_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/global_variables.dart';
import '../../../../../core/utils/is_today_check.dart';
import '../../../../../core/utils/show_snackbar.dart';
import '../../../../data/models/user.dart';
import '../../../widgets/custom_app_bar_with_date.dart';
import '../../../widgets/custom_confirmation_dialog.dart';
import '../../../widgets/custom_sell_list_tile.dart';
import '../../../widgets/error_animation.dart';
import '../../../widgets/loading_indicator.dart';

class AdminPage extends StatefulWidget {
  static const String routeName = "admin-page";
  final UserModel user;
  const AdminPage({super.key, required this.user});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  static DateTime? selectedDate = DateTime.now();
  static String date = "Bugün";
  static bool todayDate = true;
  String remotePDFpath = "";
  @override
  void initState() {
    super.initState();
    isAdminCheck(widget.user.token!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: BlocConsumer<PdfBloc, PdfState>(
        listener: (context, state) {
          if (state is PdfSuccess) {
            state.byteList != null
                ? _navigateToPage(PdfViewPage.routeName,
                    {0:state.fileName,1: state.pageTitle, 2: state.byteList,})
                : showToastMessage('Rapor şuan hazır değil');
          }

             if (state is PdfFailure) {
            showSnackBar(context, state.error!);
          }
        },
        builder: (context, state) {
          if (state is PdfLoading) {
            return const LoadingIndicator();
          }
          return _buildBody();
        },
      ),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _reports(),
          _cashProcess(),
          _production(),
          _employeesProcess(),
          _storeCounting(),
          _productsProcess(),
          _marketProcess(),
        ],
      ),
    );
  }

  _buildAppbar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: CustomAppBarWithDate(
        title: "Yönetim",
        date: date,
        //  onTap: _selectDate,
        additionalMenuItems: const [
          PopupMenuItem<String>(
            value: 'system-open-close-time',
            child: Text('Sistem çalışma saatleri'),
          ),
        ],
        onMenuItemSelected: (value) {
          if (value == 'system-open-close-time') {
            _showSystemtimeDialog();
          }
        },
      ),
    );
  }

  _reports() {
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
          'Raporlar',
        ),
        children: [
          ListTile(
            title: const Text('Günsonu'),
            trailing: IconButton(
              onPressed: () => context.read<PdfBloc>().add(
                  PdfGetEndOfTheDayRequested(date: selectedDate!, pageTitle: "Gün Sonu Raporu")),
              icon: const Icon(Icons.remove_red_eye),
              color: GlobalVariables.secondaryColor,
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.white,
            indent: 10,
            endIndent: 10,
          ),
          ListTile(
            title: const Text('Servis'),
            trailing: IconButton(
              
              onPressed: () => context.read<PdfBloc>().add(
                  PdfGetServiceRequested(
                      date: selectedDate!, pageTitle: "Servis Raporu")),
              icon: const Icon(Icons.remove_red_eye),
              color: GlobalVariables.secondaryColor,
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.white,
            indent: 10,
            endIndent: 10,
          ),
          ListTile(
            title: const Text('Pastane'),
            trailing: IconButton(
              onPressed: () => context.read<PdfBloc>().add(
                  PdfGetPastaneRequested(
                      date: selectedDate!, pageTitle: "Pastane Raporu")),
              icon: const Icon(Icons.remove_red_eye),
              color: GlobalVariables.secondaryColor,
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.white,
            indent: 10,
            endIndent: 10,
          ),
          ListTile(
            title: const Text('Hamurhane'),
            trailing: IconButton(
              onPressed: () => context.read<PdfBloc>().add(
                  PdfGetDoughFactoryRequested(
                      date: selectedDate!, pageTitle: "Hamurhane Raporu")),
              icon: const Icon(Icons.remove_red_eye),
              color: GlobalVariables.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  _cashProcess() {
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
          'Kasa',
        ),
        children: [
          CustomSellListTile(
              title: 'Nakit devir et',
              onShowDetails: () {
                // _updateBreadCounting(selectedDate!);
              },
              onAdd: todayDate
                  ? () {
                      //   _addBreadCountingDialog(selectedDate!);
                    }
                  : null),
          const Divider(
            height: 1,
            color: Colors.white,
            indent: 10,
            endIndent: 10,
          ),
          CustomSellListTile(
              title: 'Kredi kart devir et',
              onShowDetails: () {
                // _showAddedProductCountingList(1);
              },
              onAdd: todayDate
                  ? () {
                      //      _showProductCountingNotAddedList(1);
                    }
                  : null),
        ],
      ),
    );
  }

  _production() {
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
          'İmalat',
        ),
        children: [
          ListTile(
            title: const Text('Servis'),
            trailing: IconButton(
              onPressed: () {
                _navigateToPage(ServiceListPage.routeName, widget.user);
              },
              icon: const Icon(Icons.navigate_next),
              color: GlobalVariables.secondaryColor,
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.white,
            indent: 10,
            endIndent: 10,
          ),
          ListTile(
            title: const Text('Hamurhane'),
            trailing: IconButton(
              onPressed: () {
                _navigateToPage(DoughListPage.routeName, widget.user);
              },
              icon: const Icon(Icons.navigate_next),
              color: GlobalVariables.secondaryColor,
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.white,
            indent: 10,
            endIndent: 10,
          ),
          ListTile(
            title: const Text('Pastane'),
            trailing: IconButton(
              onPressed: () {
                _navigateToPage(
                    ProductionPage.routeName, {0: widget.user, 1: 1});
              },
              icon: const Icon(Icons.navigate_next),
              color: GlobalVariables.secondaryColor,
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.white,
            indent: 10,
            endIndent: 10,
          ),
          ListTile(
            title: const Text('Börek'),
            trailing: IconButton(
              onPressed: () {
                _navigateToPage(
                    ProductionPage.routeName, {0: widget.user, 1: 2});
              },
              icon: const Icon(Icons.navigate_next),
              color: GlobalVariables.secondaryColor,
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.white,
            indent: 10,
            endIndent: 10,
          ),
          //  -------NEED TO BE DONE--------
          ListTile(
            title: const Text('Dışardan alınan'),
            trailing: IconButton(
              onPressed: () {
                _navigateToPage(
                    ProductionPage.routeName, {0: widget.user, 1: 3});
              },
              icon: const Icon(Icons.navigate_next),
              color: GlobalVariables.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  _storeCounting() {
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
          'Depo',
        ),
        children: [
          CustomSellListTile(
              title: 'Günsonu',
              onShowDetails: () {
                // _updateBreadCounting(selectedDate!);
              },
              onAdd: todayDate
                  ? () {
                      //   _addBreadCountingDialog(selectedDate!);
                    }
                  : null),
          const Divider(
            height: 1,
            color: Colors.white,
            indent: 10,
            endIndent: 10,
          ),
          CustomSellListTile(
              title: 'Hamurhane',
              onShowDetails: () {
                // _showAddedProductCountingList(1);
              },
              onAdd: todayDate
                  ? () {
                      //      _showProductCountingNotAddedList(1);
                    }
                  : null),
          const Divider(
            height: 1,
            color: Colors.white,
            indent: 10,
            endIndent: 10,
          ),
          CustomSellListTile(
              title: 'Pastane',
              onShowDetails: () {
                //   _showAddedProductCountingList(2);
              },
              onAdd: todayDate
                  ? () {
                      //        _showProductCountingNotAddedList(2);
                    }
                  : null),
          const Divider(
            height: 1,
            color: Colors.white,
            indent: 10,
            endIndent: 10,
          ),
          CustomSellListTile(
              title: 'Servis',
              onShowDetails: () {
                //    _showAddedProductCountingList(3);
              },
              onAdd: todayDate
                  ? () {
                      //           _showProductCountingNotAddedList(3);
                    }
                  : null),
          const Divider(
            height: 1,
            color: Colors.white,
            indent: 10,
            endIndent: 10,
          ),
          // -------NEED TO BE DONE--------
          // CustomSellListTile(
          //     title: 'Kasa',
          //     onShowDetails: () {
          //  //     _updateCashCountingDialog("Kasa Sayımı Güncelleme");
          //     },
          //     onAdd: todayDate
          //         ? () {
          //            // _addCashCountingDialog("Kasa Sayımı");
          //           }
          //         : null),
        ],
      ),
    );
  }

  _employeesProcess() {
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
          'Personel',
        ),
        children: [
          CustomSellListTile(
              title: 'Avans',
              onShowDetails: () {
                // _updateBreadCounting(selectedDate!);
              },
              onAdd: todayDate
                  ? () {
                      //   _addBreadCountingDialog(selectedDate!);
                    }
                  : null),
          const Divider(
            height: 1,
            color: Colors.white,
            indent: 10,
            endIndent: 10,
          ),
          CustomSellListTile(
              title: 'Maaş',
              onShowDetails: () {
                // _showAddedProductCountingList(1);
              },
              onAdd: todayDate
                  ? () {
                      //      _showProductCountingNotAddedList(1);
                    }
                  : null),
        ],
      ),
    );
  }

  _productsProcess() {
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
          'Ürünler',
        ),
        children: [
          ListTile(
            title: const Text("Fırn ürünleri"),
            trailing: IconButton(
              onPressed: () {
                _navigateToPage(ProductsProcessPage.routeName, null);
              },
              icon: const Icon(Icons.arrow_outward),
              color: GlobalVariables.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  _marketProcess() {
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
          'Marketler',
        ),
        children: [
          ListTile(
            title: const Text('Market işlemleri'),
            trailing: IconButton(
              onPressed: () {
                _navigateToPage(MarketsProcessPage.routeName, null);
              },
              icon: const Icon(Icons.arrow_outward),
              color: GlobalVariables.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  _navigateToPage(String routeName, dynamic args) {
    args == null
        ? Navigator.pushNamed(
            context,
            routeName,
          )
        : Navigator.pushNamed(
            context,
            routeName,
            arguments: args,
          );
  }

  _showSystemtimeDialog() {
    context.read<SystemTimeBloc>().add(GetSystemTimeRequested());
    TextEditingController startController = TextEditingController();
    TextEditingController closeController = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<SystemTimeBloc, SystemTimeState>(
              builder: ((context, state) {
            if (state is SystemTimeSuccess && state.systemTime != null) {
              startController.text = state.systemTime!.openTime.toString();
              closeController.text = state.systemTime!.closeTime.toString();
            }
            return switch (state) {
              SystemTimeLoading() => const LoadingIndicator(),
              SystemTimeFailure() => const ErrorAnimation(),
              SystemTimeSuccess() => state.systemTime == null
                  ? CustomConfirmationDialog(
                      title: "Uyarı",
                      onTap: () {},
                      content: "Sistemde bir hata var daha sonra deneyin!")
                  : AlertDialog(
                      title: const Text("Sistem çalışma saatleri"),
                      content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: startController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  labelText: 'Başlama Saati'),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^(2[0-3]|[01]?[0-9])$')),
                              ],
                            ),
                            TextField(
                              controller: closeController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  labelText: 'Kapanma Saati'),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^(2[0-3]|[01]?[0-9])$')),
                              ],
                            ),
                          ]),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Vazgeç'),
                        ),
                        TextButton(
                          onPressed: () {
                            int openTime =
                                int.tryParse(startController.text) ?? 0;
                            int closeTime =
                                int.tryParse(closeController.text) ?? 0;

                            if (openTime != closeTime) {
                              if (state.systemTime!.openTime != openTime &&
                                  state.systemTime!.openTime != closeTime) {
                                context.read<SystemTimeBloc>().add(
                                    UpdateSystemTimeRequested(
                                        systemTime: SystemTimeModel(
                                            id: state.systemTime!.id,
                                            openTime: openTime,
                                            closeTime: closeTime)));
                              }
                              Navigator.of(context).pop();
                              return;
                            }
                            showToastMessage(
                                'Açma kapatma saatleri aynı olamaz!');
                          },
                          child: const Text('Kaydet'),
                        ),
                      ],
                    )
            };
          }));
        });
  }
}

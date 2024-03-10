// ignore_for_file: use_build_context_synchronously
import 'package:bakery_app/features/data/models/user.dart';
import 'package:bakery_app/features/presentation/pages/service/screens/service_account_page.dart';
import 'package:bakery_app/features/presentation/pages/service/screens/service_debt_page.dart';
import 'package:bakery_app/features/presentation/pages/service/screens/service_markets_page.dart';
import 'package:bakery_app/features/presentation/widgets/empty_content.dart';
import 'package:bakery_app/features/presentation/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/global_variables.dart';
import '../../../../../core/utils/is_today_check.dart';
import '../../../widgets/custom_app_bar_with_date.dart';
import '../bloc/service_added_markets/service_added_markets_bloc.dart';
import '../bloc/service_lists/service_lists_bloc.dart';
import 'service_stale_page.dart';

class ServiceListPage extends StatefulWidget {
  static const String routeName = "service-list-page";
  final UserModel user;

  const ServiceListPage({super.key, required this.user});

  @override
  State<ServiceListPage> createState() => _ServiceListPageState();
}

class _ServiceListPageState extends State<ServiceListPage> {
  static DateTime? selectedDate = DateTime.now();
  static String? date = "Bugün";
  static bool todayDate = true;
  static bool isAdmin = false;
  @override
  void initState() {
    super.initState();
    isAdmin = isAdminCheck(widget.user.token!);
    date = isAdmin ? "Bugün" : null;
    context.read<ServiceListsBloc>().add(ServiceGetListsRequested(dateTime: selectedDate!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      floatingActionButton: _buildFlaotingButtons(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: _buildBody(),
    );
  }

  _buildBody() {
    return BlocBuilder<ServiceListsBloc, ServiceListsState>(
        builder: (context, state) {
      if (state is ServiceListsLoading) {
        return const LoadingIndicator();
      }
      if (state is ServiceListsSuccess) {
        if (state.serviceLists != null && state.serviceLists!.isNotEmpty) {
          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: state.serviceLists!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: GlobalVariables.secondaryColorLight,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          (index + 1).toString(),
                          style: const TextStyle(
                              fontSize: 18,
                              color: GlobalVariables.secondaryColor),
                        ),
                      ),
                      title: const Text(
                        "Servis",
                        textScaleFactor: 1.2,
                      ),
                      subtitle: Text(
                        getFormattedDateTime(state.serviceLists![index].date!),
                      ),
                      onTap: ()  {
                        bool result = canEdit(state.serviceLists![index].userId!);
                        Navigator.pushNamed(
                          context, ServiceMarketsPage.routeName, arguments: {
                          0: state.serviceLists![index].id,
                          1: result,
                          2:widget.user.id
                        });
                      },
                    ),
                  ),
                );
              });
        }
      }
      return const EmptyContent();
    });
  }

  _buildAppbar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: CustomAppBarWithDate(
        title: "Servis",
        date: date,
        onTap: _selectDate,
        additionalMenuItems: const [
          PopupMenuItem<String>(
            value: 'debt',
            child: Text('Borçlar'),
          ),
        ],
        onMenuItemSelected: (value) {
          if (value == 'debt') {
            Navigator.pushNamed(context, ServiceDebtPage.routeName);
          }
        },
      ),
    );
  }

  Future<void> _selectDate() async {
    var newDate = await showDatePicker(
        context: context,
        initialDate: selectedDate!,
        firstDate: DateTime(2023),
        lastDate: DateTime.now());

    if (selectedDate != null && newDate != null && !checkDate(newDate)) {
      selectedDate = newDate;
      setState(() {
        context
            .read<ServiceListsBloc>()
            .add(ServiceGetListsRequested(dateTime: selectedDate!));
        todayDate = isToday(selectedDate!);
        todayDate
            ? date = 'Bugün'
            : date = selectedDate.toString().split(" ")[0];
      });
    }
  }

  bool checkDate(DateTime newDate) {
    return newDate.year == selectedDate!.year &&
        newDate.month == selectedDate!.month &&
        newDate.day == selectedDate!.day;
  }

  _buildFlaotingButtons() {
    if (todayDate || isAdmin) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              heroTag: "Service Account",
              onPressed: () {
                Navigator.pushNamed(context, ServiceAccountPage.routeName,arguments: selectedDate);
              },
              backgroundColor: GlobalVariables.secondaryColor,
              tooltip: 'Servis Hesabı',
              child: const Icon(
                Icons.calculate,
                color: Colors.white,
              ),
            ),
            FloatingActionButton(
              heroTag: "Service Stale Bread",
              onPressed: () {
                Navigator.pushNamed(context, ServiceStalePage.routeName,arguments: selectedDate);
              },
              backgroundColor: GlobalVariables.secondaryColor,
              tooltip: 'Bayat Ekmek',
              child: const Icon(
                Icons.replay,
                color: Colors.white,
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                context.read<ServiceAddedMarketsBloc>().add(ServiceGetAddedMarketsRequested(listId: 0));
                Navigator.pushNamed(context, ServiceMarketsPage.routeName, arguments: {
                  0: 0,
                  1: true,
                  2:widget.user.id
                }).then((value) => setState(
                      () {
                        context.read<ServiceListsBloc>().add(
                            ServiceGetListsRequested(dateTime: selectedDate!));
                      },
                    ));
              },
              backgroundColor: GlobalVariables.secondaryColor,
              heroTag: 'Add Service List',
              tooltip: 'Yeni Servis Ekle',
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    }
    return null;
  }

  bool canEdit(int userId)  {
   
    return (widget.user.id == userId && isToday(selectedDate!)) || isAdmin;
  }
}

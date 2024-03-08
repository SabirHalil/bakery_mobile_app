import 'package:bakery_app/features/data/models/user.dart';
import 'package:bakery_app/features/presentation/pages/production/screens/production_page.dart';
import 'package:bakery_app/features/presentation/pages/sell_assistance/screen_parts/counting_widget.dart';
import 'package:bakery_app/features/presentation/pages/sell_assistance/screen_parts/expense_widget.dart';
import 'package:bakery_app/features/presentation/pages/sell_assistance/screen_parts/service_widget.dart';
import 'package:bakery_app/features/presentation/pages/sell_assistance/screen_parts/stale_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/is_today_check.dart';
import '../../../widgets/custom_app_bar_with_date.dart';

class SellAssistancePage extends StatefulWidget {
  static const String routeName = "sell-assistance-page";
  final UserModel user;
  const SellAssistancePage({super.key, required this.user});

  @override
  State<SellAssistancePage> createState() => _SellAssistancePageState();
}

class _SellAssistancePageState extends State<SellAssistancePage> {
  static DateTime? selectedDate = DateTime.now();
  static String? date;
  static bool todayDate = true;
  static bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    isAdmin = isAdminCheck(widget.user.token!);
    date = isAdmin ? "Bugün" : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ExpenseWidget(userId: widget.user.id!, selectedDate: selectedDate!,todayDate: todayDate,isAdmin: isAdmin,),
          ServiceWidget(userId: widget.user.id!, selectedDate: selectedDate!,todayDate: todayDate,isAdmin: isAdmin,),
          StaleWidget( selectedDate: selectedDate!,todayDate: todayDate,isAdmin: isAdmin,),
          CountingWidget(userId: widget.user.id!, selectedDate: selectedDate!,todayDate: todayDate,isAdmin: isAdmin,),
        ],
      ),
    );
  }

  _buildAppbar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: CustomAppBarWithDate(
        title: "Tezgah",
        date: date,
        onTap: _selectDate,
        additionalMenuItems: const [
          PopupMenuItem<String>(
            value: 'purchesed-products',
            child: Text('Dışardan alınan ürünler'),
          ),
        ],
        onMenuItemSelected: (value) {
          if (value == 'purchesed-products') {
            Navigator.pushNamed(context, ProductionPage.routeName,
                arguments: widget.user);
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

}

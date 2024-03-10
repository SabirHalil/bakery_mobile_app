// ignore_for_file: use_build_context_synchronously

import 'package:bakery_app/core/constants/constants.dart';
import 'package:bakery_app/core/constants/global_variables.dart';
import 'package:bakery_app/features/presentation/pages/dough/screens/dough_product_page.dart';
import 'package:bakery_app/features/presentation/widgets/custom_app_bar_with_date.dart';
import 'package:bakery_app/features/presentation/widgets/error_animation.dart';
import 'package:bakery_app/features/presentation/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/is_today_check.dart';
import '../../../../data/models/user.dart';
import '../../../widgets/empty_content.dart';
import '../bloc/dough_added_products/dough_added_products_bloc.dart';
import '../bloc/dough_lists/dough_factory_bloc.dart';

class DoughListPage extends StatefulWidget {
  static const String routeName = "dough-list-page";
  final UserModel user;
  const DoughListPage({super.key, required this.user});

  @override
  State<DoughListPage> createState() => _DoughListPageState();
}

class _DoughListPageState extends State<DoughListPage> {
  static String? date = "Bugün";
  static bool todayDate = true;
  static DateTime? selectedDate = DateTime.now();
  static bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    isAdmin = isAdminCheck(widget.user.token!);
    date = isAdmin ? "Bugün" : null;
    context.read<DoughFactoryBloc>().add(DoughGetListsRequested(dateTime: selectedDate!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppbar(),
        floatingActionButton: _buildFloatingButton(),
        body: _buildBody());
  }

  _buildBody() {
    return BlocBuilder<DoughFactoryBloc, DoughFactoryState>(
        builder: (context, state) {
      return switch (state) {
        DoughFactoryLoading() => const LoadingIndicator(),
        DoughFactoryFailure() => const ErrorAnimation(),
        DoughGetListsSuccess() => state.doughLists!.isEmpty
            ? const EmptyContent()
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: state.doughLists!.length,
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
                        title: Text(
                          state.doughLists![index].userName!,
                          textScaleFactor: 1.2,
                        ),
                        subtitle: Text(
                          getFormattedDateTime(state.doughLists![index].date!),
                        ),
                        onTap: ()  {
                          bool result = canEdit(state.doughLists![index].userId!);
                          Navigator.pushNamed(
                              context, DoughProductPage.routeName, arguments: {
                            0: state.doughLists![index].id,
                            1: result,
                            2:selectedDate,
                            3:widget.user.id
                          });
                        },
                      ),
                    ),
                  );
                })
      };
    });
  }

  _buildFloatingButton() {
    
    if (todayDate || isAdmin) {
      return FloatingActionButton(
        onPressed: () {
          context.read<DoughAddedProductsBloc>().add(DoughGetAddedProductsRequested(listId: 0));
          Navigator.pushNamed(context, DoughProductPage.routeName, arguments: {
            0: 0,
            1: true,
            2:selectedDate,
            3:widget.user.id
          }).then((value) => setState(
                () {
                  context
                      .read<DoughFactoryBloc>()
                      .add(DoughGetListsRequested(dateTime: selectedDate!));
                },
              ));
         
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

  _buildAppbar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: CustomAppBarWithDate(
        title: "Hamurhane",
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
        lastDate: DateTime.now());

    if (selectedDate != null && newDate != null && !checkDate(newDate)) {
      selectedDate = newDate;
      setState(() {
        context
            .read<DoughFactoryBloc>()
            .add(DoughGetListsRequested(dateTime: selectedDate!));
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

 bool canEdit(int userId) {
   
    return (widget.user.id == userId && isToday(selectedDate!)) || isAdmin;
  }
}

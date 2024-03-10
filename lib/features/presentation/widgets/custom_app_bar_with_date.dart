import 'package:bakery_app/core/constants/global_variables.dart';
import 'package:bakery_app/features/data/data_sources/local/shared_preference.dart';
import 'package:bakery_app/features/presentation/pages/auth/screens/login_page.dart';
import 'package:flutter/material.dart';

import 'custom_confirmation_dialog.dart';

class CustomAppBarWithDate extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final String? date;
  final VoidCallback? onTap;
  final List<PopupMenuItem<String>> additionalMenuItems;
  final Function(String)? onMenuItemSelected;
  const CustomAppBarWithDate(
      {super.key,
      required this.title,
      this.date,
      this.onTap,
      this.additionalMenuItems = const [],
      this.onMenuItemSelected});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: GlobalVariables.secondaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
      ),
      centerTitle: true,
      title: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          ),
          if (date != null)
            const SizedBox(
              height: 10,
            ),
          if (date != null)
            GestureDetector(
              onTap: onTap,
              child: Text(
                date!,
                style: const TextStyle(color: Colors.white),
              ),
            )
        ],
      ),
      actions: [
        PopupMenuButton<String>(
          color: Colors.white,
          itemBuilder: (context) {
            List<PopupMenuItem<String>> items = List.from(additionalMenuItems);
            items.add(const PopupMenuItem<String>(
              value: 'logout',
              child: Text('Çıkış Yap'),
            ));
            return items;
          },
          onSelected: (value) async {
            if (value == 'logout') {
              _logoutUser(context);
            } else {
              onMenuItemSelected!(value);
            }
          },
        ),
      ],
    );
  }

  _logoutUser(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomConfirmationDialog(
              title: 'Çıkış Yap',
              onTap: () async {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginPage.routeName, (route) => false);
                await UserPreferences.clearUser();
              },
              content: 'Çıkış yapmak için emin misiniz?');
        });
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

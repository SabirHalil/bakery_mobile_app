import 'package:bakery_app/core/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData theme() {
  return ThemeData(
    colorScheme:
        ColorScheme.fromSeed(seedColor: GlobalVariables.secondaryColor),
    useMaterial3: true,
    dividerColor: Colors.transparent,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: appBarTheme(),
   
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent),
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Color(0XFF8B8B8B)),
    titleTextStyle: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
  );
}

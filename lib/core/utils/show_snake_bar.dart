import 'package:bakery_app/injection_container.dart';
import 'package:flutter/material.dart';

void showSnakeBar(String message, VoidCallback? function,String? label) {
    ScaffoldMessenger.of(sl<GlobalKey<NavigatorState>>().currentContext!).showSnackBar(
      SnackBar(
        content: Text(message),
        action: function != null && label != null ? 
          SnackBarAction(label: label, onPressed: function)
        :null,
      ),
    );
  }
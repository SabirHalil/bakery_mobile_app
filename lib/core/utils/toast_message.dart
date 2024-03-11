import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToastMessage(String message, {int duration=0}){
  Fluttertoast.showToast(
  msg: message,
  toastLength: duration == 0?Toast.LENGTH_SHORT:Toast.LENGTH_LONG, // or Toast.LENGTH_LONG
  gravity: ToastGravity.BOTTOM, // You can change the gravity to control the position
  timeInSecForIosWeb: 1, // Duration for iOS/Web
  backgroundColor:  Colors.grey.shade800,
  textColor: Colors.white,
  fontSize: 16.0,
);

}
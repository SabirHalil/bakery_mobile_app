

import 'package:intl/intl.dart';

const String  baseUrl= "https://192.168.1.8:7207";

String getFormattedDateTime(DateTime dateTime){
  return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
}

String getFromattedDate(DateTime date) {
  return DateFormat('yyyy_MM_d').format(date);
}

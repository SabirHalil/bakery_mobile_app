

import 'package:intl/intl.dart';

const String  baseUrl= "http://93.190.8.250:6500";

String getFormattedDateTime(DateTime dateTime){
  return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
}

String getFromattedDate(DateTime date) {
  return DateFormat('yyyy_MM_d').format(date);
}

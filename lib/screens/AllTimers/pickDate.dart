import 'package:flutter/material.dart';

Future<DateTime> pickDate(BuildContext context) async {
  DateTime dateTime = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now().subtract(Duration(days: 365 * 6)),
    lastDate: DateTime.now().add(Duration(days: 365 * 5)),
    locale: Locale('uk'),
  );

  return dateTime;
}

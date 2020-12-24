import 'package:flutter/material.dart';
import 'package:dmb_timer_3/utilities/global_var.dart';
import 'package:dmb_timer_3/utilities/global_constants.dart';
import 'package:dmb_timer_3/screens/home/calculate_date.dart' as calculateDate;
import 'package:dmb_timer_3/screens/home/TimeLeftHelpContent.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeLeft extends StatelessWidget {
  final ValueNotifier<int> valueNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color(0x65f05059),
            borderRadius: BorderRadius.circular(7.0),
            border: Border.all(width: 1.0, color: Colors.white)),
        height: 200,
        width: 400 / 2.2,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 44,
                child: Container(
                  width: 400 / 2.2,
                  child: Center(
                    child: Text(
                      'Залишилось днів',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                height: 30,
                width: 45,
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => helpButton(context));
                  },
                  child: Icon(
                    Icons.help,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
            ValueListenableBuilder(
              builder: (BuildContext context, int value, Widget child) {
                return Center(
                    child: Text(
                  calculateDate.leftDay(DATE_TIME_END).toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ));
              },
              valueListenable: valueNotifier,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: MaterialButton(
                onPressed: () {
                  pickDateLeft(context);
                },
                child: Text(
                  'Змінити',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ));
  }

  helpButton(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Дата завершення: ' +
            DateTime.fromMillisecondsSinceEpoch(DATE_TIME_END)
                .toIso8601String()
                .substring(0, 10),
      ),
      content: TimeLeftHelpContent(),
      actions: <Widget>[
        MaterialButton(
          elevation: 3.0,
          child: Text('Закрити'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  pickDateLeft(BuildContext context) async {
    DateTime dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 365 * 6)),
      lastDate: DateTime.now().add(Duration(days: 365 * 5)),
      locale: Locale('uk'),
    );

    if (dateTime != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      DATE_TIME_END = await prefs
          .setInt(DATE_END_KEY, dateTime.millisecondsSinceEpoch)
          .then((bool success) {
        valueNotifier.value = dateTime.millisecondsSinceEpoch;
        PERCENT_VALUE.value = calculateDate.percentPassed(
            DATE_TIME_START, dateTime.millisecondsSinceEpoch, false);
        return dateTime.millisecondsSinceEpoch;
      });
    }
  }
}

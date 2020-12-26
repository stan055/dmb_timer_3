import 'package:dmb_timer_3/screens/home/widgets/left_help_button/LeftHelpButton.dart';
import 'package:flutter/material.dart';
import 'package:dmb_timer_3/utilities/global_var.dart';
import 'package:dmb_timer_3/utilities/calculate_date.dart';
import 'package:dmb_timer_3/utilities/Pref.dart';

class TimeLeft extends StatefulWidget {
  @override
  _TimeLeftState createState() => _TimeLeftState();
}

class _TimeLeftState extends State<TimeLeft> {
  final ValueNotifier<int> valueNotifier = ValueNotifier<int>(0);

  double width;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Container(
        decoration: BoxDecoration(
            color: Color(0x65f05059),
            borderRadius: BorderRadius.circular(7.0),
            border: Border.all(width: 1.0, color: Colors.white)),
        height: 200,
        width: width / 2.2,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 44,
                child: Container(
                  width: width / 2.2,
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
              child:
                  Container(height: 30, width: 45, child: new LeftHelpButton()),
            ),
            ValueListenableBuilder(
              builder: (BuildContext context, int value, Widget child) {
                return Center(
                    child: Text(
                  leftDay(DATE_TIME_END).toString(),
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

  pickDateLeft(BuildContext context) async {
    DateTime dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 365 * 6)),
      lastDate: DateTime.now().add(Duration(days: 365 * 5)),
      locale: Locale('uk'),
    );

    if (dateTime != null) {
      int milliseconds = dateTime.millisecondsSinceEpoch;
      await Pref.saveDateEndTimer(milliseconds).then((value) => {
            valueNotifier.value = milliseconds,
            DATE_TIME_END = milliseconds,
            PERCENT_VALUE.value =
                percentPassedPro(DATE_TIME_START, milliseconds),
          });
      return milliseconds;
    }
  }
}

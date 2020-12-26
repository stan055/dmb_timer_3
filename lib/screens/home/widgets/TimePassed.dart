import 'package:flutter/material.dart';
import 'package:dmb_timer_3/utilities/global_var.dart';
import 'package:dmb_timer_3/utilities/Pref.dart';
import 'package:dmb_timer_3/screens/home/widgets/passed_help_button/PassedHelpButton.dart';
import 'package:dmb_timer_3/utilities/calculate_date.dart';

class TimePassed extends StatefulWidget {
  @override
  _TimePassedState createState() => _TimePassedState();
}

class _TimePassedState extends State<TimePassed> {
  final ValueNotifier<int> valueNotifier = ValueNotifier<int>(0);
  double width;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            color: Color(0x6040ffa1),
            border: Border.all(color: Colors.white, width: 1.0)),
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
                      'Пройшло днів',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                  height: 30, width: 45, child: new PassedHelpButton()),
            ),
            ValueListenableBuilder(
              builder: (BuildContext context, int value, Widget child) {
                return Center(
                    child: Text(
                  passedDay(DATE_TIME_START).toString(),
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
                  pickDate(context);
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

  pickDate(BuildContext context) async {
    DateTime dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 365 * 6)),
      lastDate: DateTime.now().add(Duration(days: 365 * 5)),
      locale: Locale('uk'),
    );

    if (dateTime != null) {
      int milliseconds = dateTime.millisecondsSinceEpoch;
      await Pref.saveDateStartTimer(milliseconds).then((value) => {
            valueNotifier.value = milliseconds,
            DATE_TIME_START = milliseconds,
            PERCENT_VALUE.value = percentPassedPro(milliseconds, DATE_TIME_END),
          });
      return milliseconds;
    }
  }
}

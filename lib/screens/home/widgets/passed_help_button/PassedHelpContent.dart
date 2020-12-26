import 'dart:async';
import 'package:dmb_timer_3/utilities/global_var.dart';
import 'package:dmb_timer_3/utilities/calculate_date.dart';
import 'package:dmb_timer_3/utilities/year_month_day_ukr.dart';
import 'package:flutter/material.dart';

class TimePassedHelpContent extends StatefulWidget {
  @override
  _TimePassedHelpContentState createState() => _TimePassedHelpContentState();
}

class _TimePassedHelpContentState extends State<TimePassedHelpContent> {
  String date;
  String day;
  String percent;

  @override
  void initState() {
    super.initState();

    date = passedYearMonthDayUkr(DATE_TIME_START);
    day = passedDay(DATE_TIME_START).toString();
    percent = percentPassed(DATE_TIME_START, DATE_TIME_END).toStringAsFixed(1);
    startTimer(60000);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 12,
          ),
          Text(
            'Пройшло: $date',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 19.0),
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            'У днях: $day',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 19.0),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            'У годинах: ${timePassed(DATE_TIME_START)}',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 19.0),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            'У відсотках: $percent%',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 19.0),
          )
        ],
      ),
    );
  }

  int timeForTimer = 0;
  Timer _timer;
  void startTimer(int t) {
    timeForTimer = t;
    _timer = Timer.periodic(
        Duration(
          seconds: 1,
        ), (t) {
      setState(() {
        if (timeForTimer < 1) {
          t.cancel();
        } else {
          timeForTimer = timeForTimer - 1;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

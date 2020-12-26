import 'dart:async';
import 'package:dmb_timer_3/utilities/global_var.dart';
import 'package:dmb_timer_3/utilities/calculate_date.dart';
import 'package:dmb_timer_3/utilities/year_month_day_ukr.dart';
import 'package:flutter/material.dart';

class TimeLeftHelpContent extends StatefulWidget {
  @override
  _TimeLeftHelpContentState createState() => _TimeLeftHelpContentState();
}

class _TimeLeftHelpContentState extends State<TimeLeftHelpContent> {
  String date;
  String day;
  String percent;

  @override
  void initState() {
    super.initState();

    date = leftYearMonthDayUkr(DATE_TIME_END);
    day = leftDay(DATE_TIME_END).toString();
    percent = percentLeft(DATE_TIME_START, DATE_TIME_END).toStringAsFixed(1);
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
            'Залишилось: $date',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 19.0),
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            "У днях: $day",
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 19.0),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            'У годинах: ${timeLeft(DATE_TIME_END)}',
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

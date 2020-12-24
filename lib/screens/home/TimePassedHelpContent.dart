import 'dart:async';

import 'package:dmb_timer_3/utilities/global_var.dart';

import 'package:dmb_timer_3/utilities/write_year_month_day_ukr.dart';
import 'package:flutter/material.dart';

class TimePassedHelpContent extends StatefulWidget {
  @override
  _TimePassedHelpContentState createState() => _TimePassedHelpContentState();
}

class _TimePassedHelpContentState extends State<TimePassedHelpContent> {
  String _yearPassed;
  String _dayPassed;
  String _percentPassed;

  @override
  void initState() {
    super.initState();

    _yearPassed = yearPassed();
    _dayPassed = dayPassed();
    _percentPassed = percentPassed();
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
            'Пройшло: $_yearPassed',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 19.0),
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            'У днях: $_dayPassed',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 19.0),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            'У годинах: ${hourPassed()}',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 19.0),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            'У відсотках: $_percentPassed%',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 19.0),
          )
        ],
      ),
    );
  }

  String yearPassed() {
    int timeNow = DateTime.now().millisecondsSinceEpoch - DATE_TIME_START;
    double iyear, iday;

    iday = (timeNow / 1000 / 60 / 60 / 24);
    iyear = iday / 365;

    int yearleftOfCal = iyear.toInt();
    int monthLeftOfYear =
        ((iday / (365.0 / 12.0)) - (yearleftOfCal * 12)).toInt();
    int dayLeftOfMonth =
        (iday - (((yearleftOfCal * 12) + monthLeftOfYear) * 30.416666666666667))
            .toInt();

    List<String> sYearMonthDay = new List<String>(3);
    writeYearMonthDayUkr(
        sYearMonthDay, yearleftOfCal, monthLeftOfYear, dayLeftOfMonth);

    String year, month, day;
    if (yearleftOfCal < 1)
      year = "";
    else
      year = yearleftOfCal.toString() + ' ' + sYearMonthDay[0] + " ";

    if (monthLeftOfYear < 1)
      month = "";
    else
      month = monthLeftOfYear.toString() + ' ' + sYearMonthDay[1] + " ";

    if (dayLeftOfMonth < 1)
      day = " ";
    else
      day = dayLeftOfMonth.toString() + ' ' + sYearMonthDay[2];

    String ss;
    if (!(year == "" && month == "" && day == "")) {
      ss = year + month + day;
    } else
      ss = " ";

    return ss;
  }

  String dayPassed() {
    int milisecondsOfOneDay = 86400000;
    int day = ((DateTime.now().millisecondsSinceEpoch - DATE_TIME_START) /
            milisecondsOfOneDay) ~/
        1;
    return day.toString();
  }

  String hourPassed() {
    int milisecond = DateTime.now().millisecondsSinceEpoch - DATE_TIME_START;
    double dobleSecond = milisecond / 1000;

    int intHour = (dobleSecond / 60 ~/ 60);
    int intMinut = ((dobleSecond / 60) % 60).toInt();
    int second = (dobleSecond % 60).toInt();

    String s = intHour.toString() +
        ":" +
        intMinut.toString() +
        ":" +
        second.toString();

    return s;
  }

  String percentPassed() {
    int timeLeft =
        (DateTime.now().millisecondsSinceEpoch - DATE_TIME_START).toInt();
    int timeStartEnd = (DATE_TIME_END - DATE_TIME_START).toInt();
    double percent = 100.0 / (timeStartEnd - 1) * timeLeft;

    if (percent < 100.0 && percent > 0.0)
      return percent.toStringAsFixed(1);
    else
      return '0';
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

import 'dart:async';
import 'package:dmb_timer_3/utilities/global_var.dart';

import 'package:dmb_timer_3/utilities/write_year_month_day_ukr.dart';
import 'package:flutter/material.dart';

class TimeLeftHelpContent extends StatefulWidget {
  @override
  _TimeLeftHelpContentState createState() => _TimeLeftHelpContentState();
}

class _TimeLeftHelpContentState extends State<TimeLeftHelpContent> {
  String _yearLeft;
  String _dayLeft;
  String _percentLeft;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _yearLeft = yearLeft();
    _dayLeft = dayLeft();
    _percentLeft = percentLeft();
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
            'Залишилось: $_yearLeft',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 19.0),
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            'У днях: $_dayLeft',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 19.0),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            'У годинах: ${hourLeft()}',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 19.0),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            'У відсотках: $_percentLeft%',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 19.0),
          )
        ],
      ),
    );
  }

  String yearLeft() {
    int timeNow = DATE_TIME_END - DateTime.now().millisecondsSinceEpoch;
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

  String dayLeft() {
    int milisecondsOfOneDay = 86400000;
    int day = ((DATE_TIME_END - DateTime.now().millisecondsSinceEpoch) /
            milisecondsOfOneDay) ~/
        1;
    return day.toString();
  }

  String hourLeft() {
    int milisecond = DATE_TIME_END - DateTime.now().millisecondsSinceEpoch;
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

  String percentLeft() {
    int timeLeft =
        (DateTime.now().millisecondsSinceEpoch - DATE_TIME_START).toInt();
    int timeStartEnd = (DATE_TIME_END - DATE_TIME_START).toInt();
    double percent = 100.0 - (100.0 / (timeStartEnd - 1) * timeLeft);

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

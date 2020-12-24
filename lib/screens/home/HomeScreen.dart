import 'package:dmb_timer_3/utilities/global_constants.dart';
import 'package:dmb_timer_3/utilities/global_var.dart';
import 'package:dmb_timer_3/utilities/passed_left_day.dart';
import 'package:dmb_timer_3/menu/Menu.dart';
import 'package:dmb_timer_3/screens/home/HomeBanner.dart';
import 'package:dmb_timer_3/screens/home/TimeLeftHelpContent.dart';
import 'package:dmb_timer_3/screens/home/TimePassedHelpContent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:dmb_timer_3/services/firebase.service.dart';
import 'package:dmb_timer_3/utilities/Pref.dart';
import 'package:dmb_timer_3/utilities/UserData.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  static const String id = "HOME_SCREEN";

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String imgPath = 'assets/images/army3.jpg';
  int dateTimeStart = DateTime.now().millisecondsSinceEpoch;
  int dateTimeEnd = DateTime.now().millisecondsSinceEpoch;

  getFirebaseUpdate() async {
    FirebaseService fire = new FirebaseService();
    fire.getMeta('wallpaper.jpg').then((meta) => {
          Pref.getWallpapersTimeCreated().then((time) => {
                if (meta != null &&
                    meta.timeCreated.millisecondsSinceEpoch != time)
                  {fire.downloadFile(meta.timeCreated.millisecondsSinceEpoch)}
              })
        });
  }

  getWallpaper() async {
    Pref.getWallpaper().then((value) => {
          if (value != null) {homeScreenImg = value}
        });
    setState(() {});
  }

  getData() async {
    UserData data = await Pref.getData();
    NICK_NAME_VAL = data.nickName;
    DATE_TIME_START = dateTimeStart = data.dateStart;
    DATE_TIME_END = dateTimeEnd = data.dateEnd;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    // getWallpaper();
    // getFirebaseUpdate();
    getData();
  }

  double _width, _height;
  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: menu(context),
        body: Stack(
          children: <Widget>[
            SizedBox.expand(
              child: FittedBox(
                  fit: BoxFit.fill,
                  child: SizedBox(
                    width: _width,
                    height: _height,
                    child: homeScreenImg != null
                        ? Image.file(
                            homeScreenImg,
                            width: _width,
                            height: _height,
                            fit: BoxFit.fill,
                          )
                        : Image.asset(
                            'assets/images/army3.jpg',
                            width: _width,
                            height: _height,
                            fit: BoxFit.fill,
                          ),
                  )),
            ),
            Positioned(
              right: _width / 2,
              bottom: _height / 2 - 70,
              child: homeTimePassed(context),
            ),
            Positioned(
              left: _width / 2,
              bottom: _height / 2 - 70,
              child: homeTimeLeft(context),
            ),
            Positioned(
              left: 5,
              right: 5,
              bottom: 5,
              child: Container(height: 100, width: 350, child: HomeBanner()),
            ),
            Positioned(
                top: 0,
                left: 0,
                height: 50,
                width: 50,
                child: MaterialButton(
                  onPressed: () => _scaffoldKey.currentState.openDrawer(),
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 33.0,
                  ),
                )),
            Positioned(
              bottom: _height / 2 - 85,
              left: (_width - ((_width / 2.2) * 2)) / 2,
              child: Container(
                height: 12,
                width: ((_width / 2.2) * 2),
                child: RoundedProgressBar(
                  childCenter: Text(
                      percentPassed(dateTimeStart, dateTimeEnd, false)
                          .toStringAsFixed(1),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  height: 12.0,
                  childLeft: Text('progressBar'),
                  milliseconds: 2000,
                  style: RoundedProgressBarStyle(
                      colorBorder: Colors.transparent,
                      colorProgressDark: Colors.transparent,
                      borderWidth: 0,
                      backgroundProgress: Color(0x88f05059),
                      colorProgress: Color(0x8840ffa1)),
                  percent: percentPassed(dateTimeStart, dateTimeEnd, false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  double percentPassed(int start, int end, bool boolPercent) {
    int timeLeft = (DateTime.now().millisecondsSinceEpoch - start).toInt();
    int timeStartEnd = (end - start).toInt();
    double percent = 100.0 / (timeStartEnd - 1) * timeLeft;
    if (!boolPercent) {
      if (percent >= 0.0 && percent <= 100.0)
        return percent;
      else if (percent >= 100.0) {
        return 100.0;
      } else
        return 0.0;
    } else {
      double value = (percent - percent % 10) / 100;
      if (value >= 0.0 && value <= 1.0) {
        return value;
      } else {
        return 0.0;
      }
    }
  }

  Widget homeTimeLeft(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color(0x65f05059),
            borderRadius: BorderRadius.circular(7.0),
            border: Border.all(width: 1.0, color: Colors.white)),
        height: 200,
        width: _width / 2.2,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 44,
                child: Container(
                  width: _width / 2.2,
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
                        builder: (context) => _alertDialogLeft(context));
                  },
                  child: Icon(
                    Icons.help,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
            Center(
                child: Text(
              leftDay(dateTimeEnd).toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            )),
            Positioned(
              bottom: 0,
              right: 0,
              child: MaterialButton(
                onPressed: () {
                  _pickDateLeft(context);
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

  _pickDateLeft(BuildContext context) async {
    DateTime dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 365 * 6)),
      lastDate: DateTime.now().add(Duration(days: 365 * 5)),
      locale: Locale('uk'),
    );

    if (dateTime != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      dateTimeEnd = await prefs
          .setInt(DATE_END_KEY, dateTime.millisecondsSinceEpoch)
          .then((bool success) {
        return dateTime.millisecondsSinceEpoch;
      });
      setState(() {
        DATE_TIME_END = dateTimeEnd;
      });
    }
  }

  _alertDialogLeft(BuildContext context) {
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

  Widget homeTimePassed(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            color: Color(0x6040ffa1),
            border: Border.all(color: Colors.white, width: 1.0)),
        height: 200,
        width: _width / 2.2,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 44,
                child: Container(
                  width: _width / 2.2,
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
                height: 30,
                width: 45,
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => _alertDialog(context));
                  },
                  child: Icon(
                    Icons.help,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
            Center(
                child: Text(
              passedDay(dateTimeStart).toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            )),
            Positioned(
              bottom: 0,
              right: 0,
              child: MaterialButton(
                onPressed: () {
                  _pickDate(context);
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

  _pickDate(BuildContext context) async {
    DateTime dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 365 * 6)),
      lastDate: DateTime.now().add(Duration(days: 365 * 5)),
      locale: Locale('uk'),
    );

    if (dateTime != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      dateTimeStart = await prefs
          .setInt(DATE_START_KEY, dateTime.millisecondsSinceEpoch)
          .then((bool success) {
        return dateTime.millisecondsSinceEpoch;
      });
      setState(() {
        DATE_TIME_START = dateTimeStart;
      });
    }
  }
}

_alertDialog(BuildContext context) {
  return AlertDialog(
    title: Text('Дата початку: ' +
        DateTime.fromMillisecondsSinceEpoch(DATE_TIME_START)
            .toIso8601String()
            .substring(0, 10)),
    content: TimePassedHelpContent(),
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

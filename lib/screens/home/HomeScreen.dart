import 'package:dmb_timer_3/utilities/global_constants.dart';
import 'package:dmb_timer_3/utilities/global_var.dart';
import 'package:dmb_timer_3/utilities/passed_left_day.dart';
import 'package:dmb_timer_3/menu/Menu.dart';
import 'package:dmb_timer_3/screens/home/HomeBanner.dart';
import 'package:dmb_timer_3/screens/home/TimePassedHelpContent.dart';
import 'package:dmb_timer_3/screens/home/TimeLeft.dart';
import 'package:dmb_timer_3/screens/home/calculate_date.dart' as calculateDate;
import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:dmb_timer_3/utilities/Pref.dart';
import 'package:dmb_timer_3/utilities/UserData.dart';

import 'TimePassed.dart';

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

  getData() async {
    UserData data = await Pref.getData();
    NICK_NAME_VAL = data.nickName;
    DATE_TIME_START = dateTimeStart = data.dateStart;
    DATE_TIME_END = dateTimeEnd = data.dateEnd;
    PERCENT_VALUE.value =
        calculateDate.percentPassed(DATE_TIME_START, DATE_TIME_END, false);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

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
                            imgPath,
                            width: _width,
                            height: _height,
                            fit: BoxFit.fill,
                          ),
                  )),
            ),
            Positioned(
              right: _width / 2,
              bottom: _height / 2 - 70,
              child: new TimePassed(),
            ),
            Positioned(
              left: _width / 2,
              bottom: _height / 2 - 70,
              child: new TimeLeft(),
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
                child: ValueListenableBuilder(
                  builder: (BuildContext context, double value, Widget child) {
                    return RoundedProgressBar(
                        childCenter: Text(
                            PERCENT_VALUE.value.toStringAsFixed(1),
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
                        percent: PERCENT_VALUE.value);
                  },
                  valueListenable: PERCENT_VALUE,
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
}

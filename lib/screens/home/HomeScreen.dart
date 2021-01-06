import 'package:dmb_timer_3/utilities/global_var.dart';
import 'package:dmb_timer_3/menu/Menu.dart';
import 'package:dmb_timer_3/screens/home/Widgets/HomeBanner.dart';
import 'package:dmb_timer_3/screens/home/Widgets/TimeLeft.dart';
import 'package:flutter/material.dart';
import 'widgets/progress_bar/ProgressBar.dart';
import 'package:dmb_timer_3/utilities/Pref.dart';
import 'package:dmb_timer_3/utilities/UserData.dart';
import 'package:dmb_timer_3/utilities/calculate_date.dart';
import 'Widgets/TimePassed.dart';

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

  getData() async {
    UserData data = await Pref.getData();
    NICK_NAME_VAL = data.nickName;
    DATE_TIME_START = data.dateStart;
    DATE_TIME_END = data.dateEnd;
    PERCENT_VALUE.value = percentPassedPro(DATE_TIME_START, DATE_TIME_END);
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
              bottom: _height / 2 - 86,
              left: (_width - ((_width / 2.2) * 2)) / 2,
              child: Container(
                  height: 14,
                  width: ((_width / 2.2) * 2),
                  child: new ProgressBar()),
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

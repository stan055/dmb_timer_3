import 'package:dmb_timer_3/screens/all_timers/utilities/DbHelper.dart';
import 'package:dmb_timer_3/screens/all_timers/utilities/Timer.dart';
import 'package:dmb_timer_3/screens/all_timers/utilities/sort_table.dart';
import 'package:dmb_timer_3/utilities/calculate_date.dart';
import 'package:dmb_timer_3/menu/Menu.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'widgets/AddTimerDialog.dart';
import 'widgets/MyDataTable.dart';
import 'widgets/PropTimerDialog.dart';

class AllTimersHome extends StatefulWidget {
  AllTimersHome({Key key, this.title}) : super(key: key);
  static const String id = "ALL_TIMERS_SCREEN";

  final String title;

  @override
  _AllTimersHomeState createState() => _AllTimersHomeState();
}

class _AllTimersHomeState extends State<AllTimersHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<List<Timer>> timers;
  int curUserId;

  final formKey = new GlobalKey<FormState>();
  bool isUpdating;

  int _sortColumnIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isUpdating = false;
    timers = dbHelper.getTimers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Всі Таймери',
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 0,
        leading: MaterialButton(
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
          child: Icon(
            Icons.menu,
            color: Colors.grey,
            size: 33.0,
          ),
        ),
        backgroundColor: Colors.grey[200],
      ),
      drawer: Drawer(child: menu(context)),
      backgroundColor: Colors.white,
      body: list(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[200],
        onPressed: () {
          showDialog(
              context: context, builder: (context) => new AddTimerDialog());
        },
        child: Icon(
          Icons.add,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget list() {
    return Container(
      child: Column(children: <Widget>[
        Expanded(
          child: FutureBuilder(
            future: timers,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new MyDataTable(snapshot.data);
              }

              if (null == snapshot.data || snapshot.data.lenght == 0) {
                return Text("No Data Found");
              }

              return CircularProgressIndicator();
            },
          ),
        ),
      ]),
    );
  }
}

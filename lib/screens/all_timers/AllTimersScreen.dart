import 'package:dmb_timer_3/screens/all_timers/pick_date.dart';
import 'package:dmb_timer_3/screens/all_timers/db_helper.dart';
import 'package:dmb_timer_3/screens/all_timers/Timer.dart';
import 'package:dmb_timer_3/utilities/passed_left_day.dart';
import 'package:dmb_timer_3/menu/Menu.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AllTimersHome extends StatefulWidget {
  AllTimersHome({Key key, this.title}) : super(key: key);
  static const String id = "ALL_TIMERS_SCREEN";

  final String title;

  @override
  _AllTimersHomeState createState() => _AllTimersHomeState();
}

class _AllTimersHomeState extends State<AllTimersHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DateTime dateStart, dateEnd;

  Future<List<Timer>> timers;
  TextEditingController controller = TextEditingController();
  String name;
  int curUserId;

  final formKey = new GlobalKey<FormState>();
  var dbHelper;
  bool isUpdating;
  Color formColor, buttonStartColor, buttonEndCollor;

  int _sortColumnIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
    isUpdating = false;
    name = '';
    formColor = Colors.green;
    buttonStartColor = buttonEndCollor = Colors.green[400];
    refreshList();
  }

  refreshList() {
    setState(() {
      timers = dbHelper.getTimers();
    });
  }

  clearName() {
    controller.text = '';
    name = '';
    formColor = buttonStartColor = buttonEndCollor = Colors.green;
    dateEnd = dateStart = null;
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
              context: context,
              builder: (context) => _alertDialogAddTimer(context));
        },
        child: Icon(
          Icons.add,
          color: Colors.grey,
        ),
      ),
    );
  }

  _alertDialogAddTimer(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: Text('Заповніть Форму'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text('Ім\'я:'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                height: 55,
                width: 240,
                child: TextField(
                  maxLength: 20,
                  controller: controller,
                  onChanged: (value) => name = value,
                  decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: formColor, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: formColor, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: formColor, width: 1.0),
                    ),
                    labelText: 'Введіть ім\'я',
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text('Дата початку:'),
              MaterialButton(
                onPressed: () async {
                  DateTime date = await pickDate(context);
                  setState(() {
                    date != null ? buttonStartColor = Colors.green[400] : null;
                    dateStart = date;
                  });
                },
                child: Text(
                  "${dateStart != null ? dateStart.toString().substring(0, 10) : 'Виберіть дату'}",
                  style: TextStyle(color: Colors.white),
                ),
                color: buttonStartColor,
              ),
              SizedBox(
                height: 30,
              ),
              Text('Дата завершення:'),
              MaterialButton(
                onPressed: () async {
                  DateTime date = await pickDate(context);
                  setState(() {
                    date != null ? buttonEndCollor = Colors.green[400] : null;
                    dateEnd = date;
                  });
                },
                child: Text(
                  "${dateEnd != null ? dateEnd.toString().substring(0, 10) : 'Виберіть дату'}",
                  style: TextStyle(color: Colors.white),
                ),
                color: buttonEndCollor,
              )
            ],
          ),
        ),
        actions: [
          MaterialButton(
            elevation: 3.0,
            child: Text('Скасувати'),
            onPressed: () {
              clearName();
              Navigator.of(context).pop();
            },
          ),
          MaterialButton(
            elevation: 3.0,
            child: Text('Зберегти'),
            onPressed: () async {
              bool error = false;
              Color color1 = Colors.green[400];
              Color color2 = Colors.green[400];
              Color color3 = Colors.green[400];
              if (name.length < 1) {
                color1 = Colors.red;
                error = true;
              }
              if (dateStart == null) {
                color2 = Colors.red;
                error = true;
              }
              if (null == dateEnd) {
                color3 = Colors.red;
                error = true;
              }
              if (error) {
                setState(() {
                  formColor = color1;
                  buttonStartColor = color2;
                  buttonEndCollor = color3;
                });
                return;
              }
              await save();
            },
          )
        ],
      );
    });
  }

  save() {
    Timer e = Timer(null, name, dateStart.millisecondsSinceEpoch,
        dateEnd.millisecondsSinceEpoch);
    dbHelper.save(e);
    clearName();
    refreshList();
    Navigator.of(context).pop();
  }

  bool _sortAsc = true;
  bool _sortPassed = true;
  bool _sortLeft = true;
  bool _sortName = true;
  bool _sortId = true;

  Widget list() {
    return Container(
      child: Column(children: <Widget>[
        Expanded(
          child: FutureBuilder(
            future: timers,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return dataTable(snapshot.data);
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

  dataTable(List<Timer> timers) {
    double _width = MediaQuery.of(context).size.width;
    int number = 0;
    _width = (_width - 50) / 4 - 12;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: DataTable(
            sortColumnIndex: _sortColumnIndex,
            sortAscending: _sortAsc,
            horizontalMargin: 3,
            columnSpacing: 0,
            //           dataRowHeight: 56,
            columns: [
              DataColumn(
                numeric: false,
                label: Container(width: 20, child: Text('')),
              ),
              DataColumn(
                  numeric: false,
                  label: Container(width: _width, child: Text('ІМ\'Я')),
                  onSort: (columnIndex, sortAscending) {
                    setState(() {
                      if (columnIndex == _sortColumnIndex) {
                        _sortAsc = _sortName = sortAscending;
                      } else {
                        _sortColumnIndex = columnIndex;
                        _sortAsc = _sortName;
                      }
                      onSortColum(columnIndex, sortAscending, timers);
                    });
                  }),
              DataColumn(
                  numeric: false,
                  label: Container(
                      width: _width, child: Text('ДАТИ\nПОЧАТКУ\nЗАВЕРШЕН..'))),
              DataColumn(
                  numeric: false,
                  label: Container(
                      width: _width - 7,
                      child: Text(
                        'ДНІВ\nПРОЙШ\nЛО',
                        textAlign: TextAlign.center,
                      )),
                  onSort: (columnIndex, sortAscending) {
                    setState(() {
                      if (columnIndex == _sortColumnIndex) {
                        _sortAsc = _sortPassed = sortAscending;
                      } else {
                        _sortColumnIndex = columnIndex;
                        _sortAsc = _sortPassed;
                      }
                      onSortColum(columnIndex, sortAscending, timers);
                    });
                  }),
              DataColumn(
                  label: Container(
                      width: _width - 7,
                      child: Text(
                        'ДНІВ\nЗАЛИШИЛ\nОСЬ',
                        textAlign: TextAlign.center,
                      )),
                  onSort: (columnIndex, sortAscending) {
                    setState(() {
                      if (columnIndex == _sortColumnIndex) {
                        _sortAsc = _sortLeft = sortAscending;
                      } else {
                        _sortColumnIndex = columnIndex;
                        _sortAsc = _sortLeft;
                      }
                      onSortColum(columnIndex, sortAscending, timers);
                    });
                  }),
              DataColumn(
                  numeric: true,
                  label: Container(
                    width: 25,
                    child: Text('ID'),
                  ),
                  onSort: (columnIndex, sortAscending) {
                    setState(() {
                      if (columnIndex == _sortColumnIndex) {
                        _sortAsc = _sortId = sortAscending;
                      } else {
                        _sortColumnIndex = columnIndex;
                        _sortAsc = _sortId;
                      }
                      onSortColum(columnIndex, sortAscending, timers);
                    });
                  }),
            ],
            rows: timers
                .map((timer) => DataRow(cells: [
                      DataCell(Container(
                        width: 20,
                        child: Text((++number).toString()),
                      )),
                      DataCell(
                          Container(
                            width: _width,
                            child: Text(timer.name),
                          ),
                          onTap: () => dataCellDialog(timer)),
                      DataCell(
                          Container(
                            width: _width,
                            child:
                                // Date Start text
                                Text(DateTime.fromMillisecondsSinceEpoch(
                                            timer.start)
                                        .toIso8601String()
                                        .substring(0, 10) +
                                    '\n' +
                                    // Date End text
                                    DateTime.fromMillisecondsSinceEpoch(
                                            timer.end)
                                        .toIso8601String()
                                        .substring(0, 10)),
                          ),
                          onTap: () => dataCellDialog(timer)),
                      DataCell(
                          Container(
                              width: _width,
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Column(
                                children: [
                                  // Time passed
                                  CircularPercentIndicator(
                                    radius: 20.0,
                                    lineWidth: 2.0,
                                    percent:
                                        percentPassed(timer.start, timer.end) /
                                            100,
                                    center: new Text(
                                      percentPassed(timer.start, timer.end)
                                          .toStringAsFixed(1),
                                      style: TextStyle(
                                          fontSize: 7, color: Colors.green),
                                    ),
                                    progressColor: Colors.green,
                                  ),
                                  Text(passedDay(timer.start).toString()),
                                ],
                              )),
                          onTap: () => dataCellDialog(timer)),
                      DataCell(
                          Container(
                              width: _width,
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Column(
                                children: [
                                  // Time left
                                  CircularPercentIndicator(
                                    radius: 20.0,
                                    lineWidth: 2.0,
                                    percent:
                                        percentLeft(timer.start, timer.end) /
                                            100,
                                    center: new Text(
                                      percentLeft(timer.start, timer.end)
                                          .toStringAsFixed(1),
                                      style: TextStyle(
                                          fontSize: 7, color: Colors.red),
                                    ),
                                    progressColor: Colors.red,
                                  ),
                                  Text(leftDay(timer.end).toString())
                                ],
                              )),
                          onTap: () => dataCellDialog(timer)),
                      DataCell(
                          Container(
                            width: 25,
                            child: Text(timer.id.toString()),
                          ),
                          onTap: () => dataCellDialog(timer))
                    ]))
                .toList()),
      ),
    );
  }

  onSortColum(int columnIndex, bool ascending, List<Timer> timers) {
    if (columnIndex == 4) {
      if (ascending) {
        timers.sort((a, b) => leftDay(a.end).compareTo(leftDay(b.end)));
      } else {
        timers.sort((a, b) => leftDay(b.end).compareTo(leftDay(a.end)));
      }
    } else if (columnIndex == 3) {
      if (ascending) {
        timers.sort((a, b) => passedDay(a.start).compareTo(passedDay(b.start)));
      } else {
        timers.sort((a, b) => passedDay(b.start).compareTo(passedDay(a.start)));
      }
    } else if (columnIndex == 1) {
      if (ascending) {
        timers.sort((a, b) => a.name.compareTo(b.name));
      } else {
        timers.sort((a, b) => b.name.compareTo(a.name));
      }
    } else if (columnIndex == 5) {
      if (ascending) {
        timers.sort((a, b) => a.id.compareTo(b.id));
      } else {
        timers.sort((a, b) => b.id.compareTo(a.id));
      }
    }
  }

  dataCellDialog(Timer timer) {
    return showDialog(
        context: context,
        builder: (context) => alertDialogTimer(context, timer));
  }

  alertDialogTimer(BuildContext context, Timer timer) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text(timer.name),
          content: Text('Дата початку          ' +
              DateTime.fromMillisecondsSinceEpoch(timer.start)
                  .toIso8601String()
                  .substring(0, 10) +
              '\n' +
              'Дата завершення  ' +
              DateTime.fromMillisecondsSinceEpoch(timer.end)
                  .toIso8601String()
                  .substring(0, 10) +
              '\n' +
              'Пройшло днів         ' +
              passedDay(timer.start).toString() +
              '\n' +
              'Залишилось днів   ' +
              leftDay(timer.end).toString()),
          actions: [
            MaterialButton(
              elevation: 3.0,
              child: Text(
                'Видалити Таймер',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                dbHelper.delete(timer.id);
                refreshList();
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              elevation: 3.0,
              child: Text(
                'Закрити',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

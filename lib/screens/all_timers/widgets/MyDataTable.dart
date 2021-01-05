import 'package:flutter/material.dart';
import 'package:dmb_timer_3/screens/all_timers/utilities/Timer.dart';
import 'package:dmb_timer_3/screens/all_timers/utilities/sort_table.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:dmb_timer_3/utilities/calculate_date.dart';
import 'PropTimerDialog.dart';

class MyDataTable extends StatefulWidget {
  MyDataTable(this.timers);
  final List<Timer> timers;

  @override
  _MyDataTableState createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    globalTimers = widget.timers;
  }

  int _sortColumnIndex;
  bool _sortAsc = true;
  bool _sortPassed = true;
  bool _sortLeft = true;
  bool _sortName = true;
  bool _sortId = true;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    int number = 0;
    _width = (_width - 50) / 4 - 12;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ValueListenableBuilder(
        builder: (BuildContext context, int value, Widget child) {
          return Center(
            child: DataTable(
                sortColumnIndex: _sortColumnIndex,
                sortAscending: _sortAsc,
                horizontalMargin: 3,
                columnSpacing: 0,
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
                          onSortColum(columnIndex, sortAscending, globalTimers);
                        });
                      }),
                  DataColumn(
                      numeric: false,
                      label: Container(
                          width: _width,
                          child: Text('ДАТИ\nПОЧАТКУ\nЗАВЕРШЕН..'))),
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
                          onSortColum(columnIndex, sortAscending, globalTimers);
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
                          onSortColum(columnIndex, sortAscending, globalTimers);
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
                          onSortColum(columnIndex, sortAscending, globalTimers);
                        });
                      }),
                ],
                rows: globalTimers
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
                                        percent: percentPassed(
                                                timer.start, timer.end) /
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
                                        percent: percentLeft(
                                                timer.start, timer.end) /
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
          );
        },
        valueListenable: globalTimersLength,
      ),
    );
  }

  dataCellDialog(Timer timer) {
    return showDialog(
            context: context,
            builder: (context) => new PropTimerDialog(globalTimers, timer))
        .whenComplete(() => setState(() {}));
  }
}
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
    super.initState();
    globalTimers = widget.timers;
  }

  int _sortColumnIndex;
  bool _sortAsc = true;
  bool _sortPassed = true;
  bool _sortLeft = true;
  bool _sortName = true;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    _width = (_width - 50) / 4 - 5;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ValueListenableBuilder(
        builder: (BuildContext context, int value, Widget child) {
          int number = 0;
          return Center(
            child: DataTable(
                sortColumnIndex: _sortColumnIndex,
                sortAscending: _sortAsc,
                horizontalMargin: 5,
                columnSpacing: 1,
                columns: [
                  DataColumn(
                    numeric: false,
                    label: Container(width: 17, child: Text('')),
                  ),
                  DataColumn(
                      numeric: false,
                      label: Container(width: _width -3, child: Text('Ім\'я')),
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
                          width: _width +10,
                          child: Text('Початок /\nЗавершен.'))),
                  DataColumn(
                      numeric: false,
                      label: Container(
                          width: _width -10,
                          child: Text(
                            'Днів\nПройшло',
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
                          width: _width,
                          child: Text(
                            'Днів\nЗалишило.',
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
                ],
                rows: globalTimers
                    .map((timer) => DataRow(cells: [
                          DataCell(Container(
                            width: 17,
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
                                width: _width +5,
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
                                  width: _width -12,
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
                                  width: _width -5,
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

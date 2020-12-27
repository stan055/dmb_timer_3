import 'package:flutter/material.dart';
import 'package:dmb_timer_3/screens/all_timers/utilities/Timer.dart';
import 'package:dmb_timer_3/utilities/calculate_date.dart';
import 'package:dmb_timer_3/screens/all_timers/utilities/DbHelper.dart';

class PropTimerDialog extends StatelessWidget {
  PropTimerDialog(this.timer);
  final Timer timer;

  @override
  Widget build(BuildContext context) {
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
  }
}

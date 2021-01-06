import 'package:flutter/material.dart';
import 'PassedHelpContent.dart';
import 'package:dmb_timer_3/utilities/global_var.dart';

class PassedHelpButton extends StatefulWidget {
  @override
  _PassedHelpButtonState createState() => _PassedHelpButtonState();
}

class _PassedHelpButtonState extends State<PassedHelpButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        showDialog(context: context, builder: (context) => helpButton(context));
      },
      child: Icon(
        Icons.help,
        color: Colors.white70,
        size: 32.0,
      ),
    );
  }

  helpButton(BuildContext context) {
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
}

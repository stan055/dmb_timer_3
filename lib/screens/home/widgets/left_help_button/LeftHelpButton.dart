import 'package:flutter/material.dart';
import 'LeftHelpContent.dart';
import 'package:dmb_timer_3/utilities/global_var.dart';

class LeftHelpButton extends StatefulWidget {
  @override
  _LeftHelpButtonState createState() => _LeftHelpButtonState();
}

class _LeftHelpButtonState extends State<LeftHelpButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        showDialog(context: context, builder: (context) => helpButton(context));
      },
      child: Icon(
        Icons.help,
        color: Colors.white70,
      ),
    );
  }

    helpButton(BuildContext context) {
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
}

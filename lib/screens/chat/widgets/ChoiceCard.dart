import 'package:flutter/material.dart';
import '../utilities/Choice.dart';

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, color: Colors.cyanAccent),
            Text(
              choice.title,
            ),
          ],
        ),
      ),
    );
  }
}

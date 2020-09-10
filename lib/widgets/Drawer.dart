import 'package:dmb_timer_3/screens/AllTimers/AllTimersHome.dart';
import 'package:dmb_timer_3/screens/ChatScreen.dart';
import 'package:dmb_timer_3/screens/DocumentsScreen.dart';
import 'package:dmb_timer_3/screens/MyHomePage.dart';
import 'package:dmb_timer_3/screens/RankScreen.dart';
import 'package:dmb_timer_3/screens/ShevronsScreen.dart';
import 'package:dmb_timer_3/screens/TthScreen.dart';
import 'package:dmb_timer_3/utilities/constants.dart';
import 'package:flutter/material.dart';

Widget drawer(BuildContext context) {
  return Container(
    color: Colors.white,
    width: 300.0,
    child: ListView(
      children: <Widget>[
        DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[Colors.grey[700], Colors.grey]),
              image: DecorationImage(
                  image: ExactAssetImage("assets/images/army3.jpg"),
                  fit: BoxFit.none,
                  alignment: Alignment.topLeft),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  '${NICK_NAME_VAL != null ? 'Привіт ' + NICK_NAME_VAL : 'Привіт друг'}',
                  style: TextStyle(color: Colors.white),
                )
              ],
            )),
        ListTile(
          leading: Icon(Icons.chat),
          title: Text('Чат'),
          onTap: () {
            Navigator.of(context).pushNamed(ChatScreen.id);
          },
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Головна'),
          onTap: () {
            Navigator.of(context).pushNamed(MyHomePage.id);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.timer,
          ),
          title: Text('Всі Таймери'),
          onTap: () {
            Navigator.of(context).pushNamed(AllTimersHome.id);
          },
        ),
        ListTile(
          leading: Icon(Icons.location_searching),
          title: Text('ТТХ Зброї'),
          onTap: () {
            Navigator.of(context).pushNamed(TthList.id);
          },
        ),
        ListTile(
          leading: Icon(Icons.grade),
          title: Text('Звання України'),
          onTap: () {
            Navigator.of(context).pushNamed(RankScreen.id);
          },
        ),
        ListTile(
          leading: Icon(Icons.beenhere),
          title: Text('Шеврони ЗСУ'),
          onTap: () {
            Navigator.of(context).pushNamed(ShevronsScreen.id);
          },
        ),
        ListTile(
          leading: Icon(Icons.library_books),
          title: Text('Рапорти Обов\'язки Забезпечення'),
          onTap: () {
            Navigator.of(context).pushNamed(ListDocumentsScreen.id);
          },
        ),
      ],
    ),
  );
}

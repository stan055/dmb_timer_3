import 'package:dmb_timer_3/screens/all_timers/AllTimersScreen.dart';
import 'package:dmb_timer_3/screens/chat/ChatScreen.dart';
import 'package:dmb_timer_3/screens/documents/DocumentsScreen.dart';
import 'package:dmb_timer_3/screens/home/HomeScreen.dart';
import 'package:dmb_timer_3/screens/rank/RankScreen.dart';
import 'package:dmb_timer_3/screens/shevrons/ShevronsScreen.dart';
import 'package:dmb_timer_3/screens/tth/TthScreen.dart';
import 'package:dmb_timer_3/utilities/global_var.dart';
import 'package:flutter/material.dart';

Widget menu(BuildContext context) {
  return Container(
    color: Colors.grey[200],
    width: 300.0,
    child: ListView(
      children: <Widget>[
        DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  '${NICK_NAME_VAL != null ? 'Привіт ' + NICK_NAME_VAL : 'Привіт друг'}',
                  
                )
              ],
            )),
        ListTile(
          leading: Icon(Icons.chat, color: Colors.grey,),
          title: Text('Чат'),
          onTap: () {
            Navigator.of(context).pushNamed(ChatScreen.id);
          },
        ),
        ListTile(
          leading: Icon(Icons.home, color: Colors.grey),
          title: Text('Головна'),
          onTap: () {
            Navigator.of(context).pushNamed(MyHomePage.id);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.timer, color: Colors.grey
          ),
          title: Text('Всі Таймери'),
          onTap: () {
            Navigator.of(context).pushNamed(AllTimersHome.id);
          },
        ),
        ListTile(
          leading: Icon(Icons.location_searching, color: Colors.grey),
          title: Text('ТТХ Зброї'),
          onTap: () {
            Navigator.of(context).pushNamed(TthList.id);
          },
        ),
        ListTile(
          leading: Icon(Icons.grade, color: Colors.grey),
          title: Text('Звання України'),
          onTap: () {
            Navigator.of(context).pushNamed(RankScreen.id);
          },
        ),
        ListTile(
          leading: Icon(Icons.beenhere, color: Colors.grey),
          title: Text('Шеврони ЗСУ'),
          onTap: () {
            Navigator.of(context).pushNamed(ShevronsScreen.id);
          },
        ),
        ListTile(
          leading: Icon(Icons.library_books, color: Colors.grey,),
          title: Text('Рапорти Обов\'язки Забезпечення',),
          onTap: () {
            Navigator.of(context).pushNamed(ListDocumentsScreen.id);
          },
        ),
      ],
    ),
  );
}

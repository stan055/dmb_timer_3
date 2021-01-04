import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dmb_timer_3/menu/Menu.dart';
import 'package:dmb_timer_3/utilities/global_constants.dart';
import 'package:dmb_timer_3/utilities/global_var.dart';
import 'widgets/SetNickNameScreen.dart';
import 'utilities/Choice.dart';
import 'utilities/onBindViewHolder.dart';
import 'widgets/MessageBody.dart';
import 'widgets/TextComposer.dart';

const String _data_base_name = "messages";
const int coutnMaxChatMessages = COUNT_CHAT_MAX_MESSEGES;

class ChatScreen extends StatefulWidget {
  static const String id = "REALTIMECHAT";

  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final DatabaseReference _messageDatabaseReference;

  ChatScreenState()
      : _messageDatabaseReference =
            FirebaseDatabase.instance.reference().child(_data_base_name);

  void _select(Choice choice) {
    setState(() {
      NICK_NAME_VAL = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: menu(context),
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        leading: MaterialButton(
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
            child: Icon(Icons.menu, color: Colors.black87)),
        title: Text("Чат", style: TextStyle(color: Colors.black87)),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 1.0,
        actions: <Widget>[
          PopupMenuButton<Choice>(
            icon: Icon(Icons.more_vert, color: Colors.black87),
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return choices.map((Choice choice) {
                return PopupMenuItem<Choice>(
                  value: choice,
                  child: Text(choice.title),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: NICK_NAME_VAL == null
          ? new SetNickNameScreen()
          : Container(
              decoration: Theme.of(context).platform == TargetPlatform.iOS
                  ? BoxDecoration(
                      border: Border(
                      top: BorderSide(color: Colors.grey[200]),
                    ))
                  : BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            'assets/images/chatBackground.jpeg',
                          ),
                          fit: BoxFit.fill)),
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: StreamBuilder(
                      stream: _messageDatabaseReference.onValue,
                      builder: (context, snap) {
                        if (snap.hasData &&
                            !snap.hasError &&
                            snap.data.snapshot.value != null) {
                          DataSnapshot snapshot = snap.data.snapshot;
                          Map<dynamic, dynamic> _list = Map();
                          var st = new SplayTreeMap<String, Object>();

                          _list = snapshot.value;

                          _list.forEach((k, v) => st[k] = v);

                          // Deleting old messages
                          st.length > coutnMaxChatMessages
                              ? _messageDatabaseReference
                                  .child(st.firstKey())
                                  .remove()
                              : (_) {};

                          return snap.data.snapshot.value == null
                              ? SizedBox()
                              : ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: st.length,
                                  reverse: true,
                                  itemBuilder: (context, index) =>
                                      new MessageBody(onBindViewHolder(st.values
                                          .elementAt(st.length - 1 - index))));
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                  Divider(height: 1.0),
                  Container(
                    decoration:
                        BoxDecoration(color: Theme.of(context).cardColor),
                    child: new TextComposer(),
                  ),
                ],
              ),
            ),
    );
  }
}

import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dmb_timer_3/menu/Menu.dart';
import 'package:dmb_timer_3/utilities/constants.dart';
import 'package:quartet/quartet.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _data_base_name = "messages";
const int coutnMaxChatMessages = COUNT_CHAT_MAX_MESSEGES;

class ChatScreen extends StatefulWidget {
  static const String id = "REALTIMECHAT";

  
  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController _textController;
  final DatabaseReference _messageDatabaseReference;

  bool _isComposing = false;


  ChatScreenState()
      : 
        _isComposing = false,
        _textController = TextEditingController(),
        _messageDatabaseReference = 
            FirebaseDatabase.instance.reference().child(_data_base_name);

  Widget _buildTextComposer() {
    return IconTheme(
        data: IconThemeData(color: Theme.of(context).accentColor),
        child: Container(
          height: 44,
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 30,
                  maxLength: 500,
                  controller: _textController,
                  onChanged: (String text) {
                    setState(() {
                      _isComposing = text.length > 0;
                    });
                  },
                  onSubmitted: _handleSubmitted,
                  decoration:
                      InputDecoration.collapsed(hintText: "Введіть текст",),
                ),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    children: <Widget>[
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? CupertinoButton(
                              child: Text("Відправити"),
                              onPressed: _isComposing
                                  ? () => _handleSubmitted(_textController.text)
                                  : null,
                            )
                          : IconButton(
                              icon: Icon(Icons.send),
                              onPressed: _isComposing
                                  ? () => _handleSubmitted(_textController.text)
                                  : null,
                            ),
                    ],
                  ))
            ],
          ),
        ));
  }

  String _timeFromDate(){
    DateTime _dateTime = DateTime.now();
    String minutes = _dateTime.minute < 10 ? "0" + _dateTime.minute.toString() : _dateTime.minute.toString(); 
    return _dateTime.hour.toString() + ':' + minutes;
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });

    text = NICK_NAME_VAL + '   ' + _timeFromDate() + '\n' + text;
    _messageDatabaseReference.push().set(text);
  }


  void _select(Choice choice) {
    setState(() {
      NICK_NAME_VAL = null;
    });
  }


  @override
  Widget build(BuildContext context) {
   double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      drawer: menu(context),
      appBar: AppBar(
        backgroundColor:Colors.grey[200],
        leading: MaterialButton(
          onPressed: (){
            _scaffoldKey.currentState.openDrawer();
          },
          child: Icon(Icons.menu, color: Colors.black87) 
          ),
        title: Text("Чат", style: TextStyle(color: Colors.black87)),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 1.0,
        actions: <Widget>[
          PopupMenuButton<Choice>(
              icon: Icon(Icons.more_vert , color: Colors.black87),
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
      body: NICK_NAME_VAL == null ? nickNameScreen()
      : 
      Container(
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? BoxDecoration(
                border: Border(
                top: BorderSide(color: Colors.grey[200]),
              ))
            :  BoxDecoration(
               image: DecorationImage(
               image: AssetImage('assets/images/chatBackground.jpeg',),
               fit: BoxFit.fill
          )
        ),
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
                    Map<dynamic, dynamic>  _list = Map();
                    var st = new SplayTreeMap<String, Object>();
                      
                    _list = snapshot.value;
                    
                    
                    _list.forEach((k,v) => st[k] = v);
                    
                    // Удаляем старые сообщения
                    st.length > coutnMaxChatMessages ?  _messageDatabaseReference.child(st.firstKey()).remove() : (_){};

                    return snap.data.snapshot.value == null

                        ? SizedBox()

                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: st.length,
                            reverse: true,
                            itemBuilder: (context, index) => buildBody(context, st.values.elementAt(st.length - 1 - index))
                                 
                          
                          );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
          ],
        ),
      ),
    );
  }
void onBindViewHolder(String text, List<String> ss) {
        String msg = text;
        String name = "", message = "";
        bool boolName = true;
        for( int ii = 0;   ii < msg.length; ii++){
            if(boolName){

                if(charAt(msg,ii) != '\n'){

                    name += charAt(msg,ii);
                } else{

                    boolName = false;
                }
           }else {

                message += charAt(msg,ii);
            }
        }


        ss[0] = name;
        ss[1] = message;
    }

Widget buildBody(BuildContext context, String text){
  List<String> ss = List<String>(2);
  onBindViewHolder(text, ss);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 7.0, 0.0, 0.0),
            child: Text(
              ss[0],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27.0, vertical: 0.0),
            child: Material(
              color: Colors.amberAccent[100],
              borderRadius: BorderRadius.circular(10.0),
              elevation: 1.0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 17.0),
                child: Text(
                  ss[1],
                ),
              ),
            ),
          ),
          SizedBox(height: 12,)
        ],
      ),
    );
}


Widget nickNameScreen(){
  TextEditingController _nickNameController = TextEditingController();
  return Container(
    color: Colors.grey[200],
    child: Center(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
       Padding(
         padding: const EdgeInsets.fromLTRB(50,50,50,16),
         child: TextField(
           maxLength: 30,
           decoration: InputDecoration(
                          hintText: "Введіть Нікнейм",
                          border:  OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                        ),
            controller: _nickNameController,
         ),
       ),
       Container(
         padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
         child: RaisedButton(
           elevation: 5.0,
           padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
           child: Text('ПРИЙНЯТИ'),
           onPressed: () {
           if(_nickNameController.text.isNotEmpty){
          NICK_NAME_VAL = _nickNameController.text;
          setNickName(NICK_NAME_VAL);
         }
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatScreen()));
        }

           )
       )
    ],)),
  );
}

  setNickName(_nickname) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('NICK_NAME_KEY', _nickname);
  }


}


class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Змінити Нікнейм', icon: Icons.directions_car),

];

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
            Text(choice.title,),
          ],
        ),
      ),
    );
  }
}
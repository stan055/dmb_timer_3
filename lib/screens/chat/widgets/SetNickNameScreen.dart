import 'package:flutter/material.dart';
import 'package:dmb_timer_3/utilities/global_var.dart';
import '../ChatScreen.dart';
import 'package:dmb_timer_3/utilities/Pref.dart';

class SetNickNameScreen extends StatelessWidget {
  static TextEditingController _nickNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 50, 50, 16),
            child: TextField(
              maxLength: 30,
              decoration: InputDecoration(
                hintText: "Введіть Нікнейм",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
              ),
              controller: _nickNameController,
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child: RaisedButton(
                  elevation: 5.0,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text('ПРИЙНЯТИ'),
                  onPressed: () {
                    if (_nickNameController.text.isNotEmpty) {
                      NICK_NAME_VAL = _nickNameController.text;
                      Pref.setNickName(NICK_NAME_VAL);
                    }
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChatScreen()));
                  }))
        ],
      )),
    );
  }
}

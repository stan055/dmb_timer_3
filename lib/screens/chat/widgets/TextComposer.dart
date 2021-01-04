import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:dmb_timer_3/utilities/global_var.dart';
import '../utilities/timeFromDate.dart';

const String _data_base_name = "messages";

class TextComposer extends StatefulWidget {
  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  final TextEditingController _textController;
  final DatabaseReference _messageDatabaseReference;
  bool _isComposing = false;

  _TextComposerState()
      : _isComposing = false,
        _textController = TextEditingController(),
        _messageDatabaseReference =
            FirebaseDatabase.instance.reference().child(_data_base_name);

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });

    text = NICK_NAME_VAL + '   ' + timeFromDate() + '\n' + text;
    _messageDatabaseReference.push().set(text);
  }

  @override
  Widget build(BuildContext context) {
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
                  decoration: InputDecoration.collapsed(
                    hintText: "Введіть текст",
                  ),
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
}

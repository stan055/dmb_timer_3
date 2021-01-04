import 'package:flutter/material.dart';

class MessageBody extends StatelessWidget {
  MessageBody(this.ss);
  final List<String> ss;

  @override
  Widget build(BuildContext context) {
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
            padding:
                const EdgeInsets.symmetric(horizontal: 27.0, vertical: 0.0),
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
          SizedBox(
            height: 12,
          )
        ],
      ),
    );
  }
}

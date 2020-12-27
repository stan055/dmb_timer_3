import 'package:flutter/material.dart';
import 'package:dmb_timer_3/screens/documents/utilities/documents_list_val.dart';

class TextItemBuilder extends StatefulWidget {
  TextItemBuilder(this.list, this.index);
  final List<ListDocumentsRaportItem> list;
  final int index;

  @override
  _TextItemBuilderState createState() => _TextItemBuilderState();
}

class _TextItemBuilderState extends State<TextItemBuilder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: MaterialButton(
              child: Text(
                widget.list[widget.index].name,
                textAlign: TextAlign.center,
              ),
              textColor: Colors.black,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            textItem(widget.list[widget.index].val)));
              },
              color: Colors.white,
              height: 190.0,
              minWidth: 135,
              elevation: 5,
            )),
          ),
        ],
      ),
    );
  }

  Widget textItem(String text) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[200],
          leading: MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey,
              size: 33.0,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                text,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ));
  }
}

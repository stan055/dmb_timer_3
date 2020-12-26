import 'package:flutter/material.dart';
import 'package:dmb_timer_3/screens/documents/documents_list_val.dart';
import 'package:photo_view/photo_view.dart';

class ImgItemBuilder extends StatefulWidget {
  ImgItemBuilder(this.list, this.index);
  final List<ListDocumentsRaportItem> list;
  final int index;

  @override
  _ImgItemBuilderState createState() => _ImgItemBuilderState();
}

class _ImgItemBuilderState extends State<ImgItemBuilder> {
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
                            itemBuilder(widget.list[widget.index].val)));
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

  Widget itemBuilder(String img) {
    return Container(
        child: PhotoView(
      imageProvider: AssetImage(img),
    ));
  }
}

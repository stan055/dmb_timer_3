import 'package:flutter/material.dart';
import 'package:dmb_timer_3/menu/Menu.dart';
import 'package:dmb_timer_3/screens/documents/documents_list_val.dart';
import 'widgets/ImgItemBuilder.dart';
import 'widgets/TextItemBuilder.dart';

class ListDocumentsScreen extends StatefulWidget {
  static const String id = "LIST_DOCUMENTS";

  @override
  _ListDocumentsScreenState createState() => _ListDocumentsScreenState();
}

class _ListDocumentsScreenState extends State<ListDocumentsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Тека Документів',
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 0,
        leading: MaterialButton(
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
          child: Icon(
            Icons.menu,
            color: Colors.grey,
            size: 33.0,
          ),
        ),
        backgroundColor: Colors.grey[200],
      ),
      drawer: Drawer(child: menu(context)),
      body: SingleChildScrollView(
          child: Container(
        color: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0, 5),
              child: Text(
                'Приклади Рапортів',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Container(
              height: 1.0,
              color: Colors.grey,
              margin: const EdgeInsets.only(left: 10.0, right: 100.0),
            ),
            Container(
              height: 225.0,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listDocumentsRaportItems.length,
                  itemBuilder: (context, index) =>
                      new ImgItemBuilder(listDocumentsRaportItems, index)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0, 5),
              child: Text(
                'Добовий Наряд',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Container(
              height: 1.0,
              color: Colors.grey,
              margin: const EdgeInsets.only(left: 10.0, right: 100.0),
            ),
            Container(
              height: 225.0,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listDocumentsOboviazkyItems.length,
                  itemBuilder: (context, index) =>
                      new TextItemBuilder(listDocumentsOboviazkyItems, index)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0, 5),
              child: Text(
                'Обовязки Військовослужбовців',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Container(
              height: 1.0,
              color: Colors.grey,
              margin: const EdgeInsets.only(left: 10.0, right: 100.0),
            ),
            Container(
              height: 225.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listDocumentsOboviazkyZagalni.length,
                itemBuilder: (context, index) =>
                    new TextItemBuilder(listDocumentsOboviazkyZagalni, index),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0, 5),
              child: Text(
                'Інше',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Container(
              height: 1.0,
              color: Colors.grey,
              margin: const EdgeInsets.only(left: 10.0, right: 100.0),
            ),
            Container(
              height: 225.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listDocumentsInsheItems.length,
                itemBuilder: (context, index) =>
                    new TextItemBuilder(listDocumentsInsheItems, index),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

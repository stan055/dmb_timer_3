import 'package:dmb_timer_3/menu/Menu.dart';
import 'package:dmb_timer_3/screens/TthPage/TthItem.dart';
import 'package:flutter/material.dart';
import 'package:dmb_timer_3/utilities/tth_models.dart';


class TthList extends StatefulWidget {
  static const String id = "TTH_SCREEN";

  @override
  _TthListState createState() => _TthListState();
}

class _TthListState extends State<TthList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  Widget listItemCell(BuildContext ctx, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyDetailPage(items[index])));
      },
      child: Card(
          margin: EdgeInsets.all(6),
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.all(9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 70.0,
                      height: 70.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        image: DecorationImage(
                          image: AssetImage(items[index].img),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      items[index].title,
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Icon(Icons.navigate_next, color: Colors.white),
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('ТТХ Зброї', style: TextStyle(color: Colors.black87),),
        elevation: 0,
        leading: MaterialButton(
                  onPressed: () => _scaffoldKey.currentState.openDrawer(),
                  child: Icon(Icons.menu, color: Colors.grey, size: 33.0,),
                ),
        backgroundColor: Colors.grey[200],
        ),
      drawer: Drawer(child: menu(context)),
      body: Container(
        color: Colors.grey[200],
        child: Center(
          child: Stack(
            children: <Widget>[
              ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) => listItemCell(context, index),
              ),
            ],
          ),
        ),
      ),

    );
  }
}






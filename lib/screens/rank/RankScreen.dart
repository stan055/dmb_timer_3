import 'package:dmb_timer_3/screens/rank/utilities/rank_list.dart';
import 'package:dmb_timer_3/menu/Menu.dart';
import 'package:flutter/material.dart';

class RankScreen extends StatefulWidget {
  static const String id = "RANK_SCREEN";


  @override
  _RankScreenState createState() => _RankScreenState();
}

class _RankScreenState extends State<RankScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Звання України', style: TextStyle(color: Colors.black87),),
        elevation: 0,
        leading: MaterialButton(
                  onPressed: () => _scaffoldKey.currentState.openDrawer(),
                  child: Icon(Icons.menu, color: Colors.grey, size: 33.0,),
                ),
        backgroundColor: Colors.grey[200],
        ),
      drawer: Drawer(child: menu(context)),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
              child: Column(
          children: <Widget>[
            
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Сухопутні Війська',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
          ),
            Container(
              height:245.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: rankListSyhopytniVyiska.length,
                itemBuilder: (context, index) => _itemBuilder(rankListSyhopytniVyiska, index),
              ),
           ),

                   Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Повітряні Сили',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
          ),
            Container(
              height:245.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: rankListPovitraniSyly.length,
                itemBuilder: (context, index) => _itemBuilder(rankListPovitraniSyly, index),
              ),
           ),

                            Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'ВМС',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
          ),
            Container(
              height:245.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: rankListVms.length,
                itemBuilder: (context, index) => _itemBuilder(rankListVms, index),
              ),
           ),

            Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Національна Поліція України',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
          ),
            Container(
              height:245.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: rankListPoliciya.length,
                itemBuilder: (context, index) => _itemBuilder(rankListPoliciya, index),
              ),
           ),
          ],
        ),
      )
    );
  }
}

  Widget _itemBuilder(List<RankListItem> list, int index) {
    return Container(
       padding: EdgeInsets.all(5.0),
    child:   Column(
        children: <Widget>[
          SizedBox(
            height: 175.0,  
            child: Container(child:  Image.asset(list[index].img ),)),
          SizedBox(height: 5.0,),
          SizedBox(
            width: 120.0,
            child: Center(child: 
              Text(list[index].title, textAlign: TextAlign.center, 
              style: TextStyle(fontStyle: FontStyle.italic),
              )
            ),)
      ],),
    );
  }
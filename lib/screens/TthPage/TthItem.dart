import 'package:flutter/material.dart';
import '../../utilities/tth_models.dart';

class MyDetailPage extends StatefulWidget {
  TthListItem _itemList;

  MyDetailPage(TthListItem superHero) {
    _itemList = superHero;
  }

  @override
  _MyDetailPageState createState() => _MyDetailPageState(_itemList);
}

class _MyDetailPageState extends State<MyDetailPage> {
  TthListItem itemList;

  _MyDetailPageState(TthListItem superHero) {
    this.itemList = superHero;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[200],
        title: Text(itemList.title, style: TextStyle(color: Colors.black87)),
        leading: MaterialButton(
          onPressed: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back, color: Colors.black87)
        ),
      ),
      body: 
           SingleChildScrollView(
                      child: Column(
              children: <Widget>[
                Container(
                  height: 270.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(itemList.img,),
                        fit: BoxFit.cover                        
                    )
                  ),
                ),
                Container(
                  color: Colors.grey[200],
                      padding: EdgeInsets.all(25),
                      child: Text(itemList.body, style:TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
    );
  }
}

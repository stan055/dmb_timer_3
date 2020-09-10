import 'package:flutter/material.dart';
import 'package:dmb_timer_3/widgets/Drawer.dart';
import 'package:dmb_timer_3/utilities/documents_list_val.dart';
import 'package:photo_view/photo_view.dart';

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
        title: Text('Тека Документів', style: TextStyle(color: Colors.black87),),
        elevation: 0,
        leading: MaterialButton(
                  onPressed: () => _scaffoldKey.currentState.openDrawer(),
                  child: Icon(Icons.menu, color: Colors.grey, size: 33.0,),
                ),
        backgroundColor: Colors.grey[200],
        ),
      drawer: Drawer(child: drawer(context)),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[200],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
             Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0, 5),
                  child: Text('Приклади Рапортів', style: TextStyle(fontSize: 18.0),),
              ),
              Container(height: 1.0, color: Colors.grey,
                          margin: const EdgeInsets.only(left: 10.0, right: 100.0),),
              Container(
                height:225.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listDocumentsRaportItems.length,
                  itemBuilder: (context, index) => _raportItemBuilder(context, listDocumentsRaportItems, index),
                ),
            ),
              
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0, 5),
                  child: Text('Добовий Наряд', style: TextStyle(fontSize: 18.0),),
              ),
              Container(height: 1.0, color: Colors.grey,
                          margin: const EdgeInsets.only(left: 10.0, right: 100.0),),
              Container(
                height:225.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listDocumentsOboviazkyItems.length,
                  itemBuilder: (context, index) => _dobovyiNariadItemBuilder(context, listDocumentsOboviazkyItems, index),
                ),
            ),

              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0, 5),
                  child: Text('Обовязки Військовослужбовців', style: TextStyle(fontSize: 18.0),),
              ),
              Container(height: 1.0, color: Colors.grey,
                          margin: const EdgeInsets.only(left: 10.0, right: 100.0),),
              Container(
                height:225.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listDocumentsOboviazkyZagalni.length,
                  itemBuilder: (context, index) => _dobovyiNariadItemBuilder(context, listDocumentsOboviazkyZagalni, index),
                ),
            ),
            
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0, 5),
                  child: Text('Інше', style: TextStyle(fontSize: 18.0),),
              ),
              Container(height: 1.0, color: Colors.grey,
                          margin: const EdgeInsets.only(left: 10.0, right: 100.0),),
              Container(
                height:225.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listDocumentsInsheItems.length,
                  itemBuilder: (context, index) => _dobovyiNariadItemBuilder(context, listDocumentsInsheItems, index),
                ),
            ),
          ],),
        )
      ),
    );
  }
}


Widget _raportItemBuilder(BuildContext context, List<ListDocumentsRaportItem> list, int index) {
    return Container(
       padding: EdgeInsets.all(5.0),
    child:   Column(
        children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container( 
                            child: MaterialButton(
                              child: Text(list[index].name, textAlign: TextAlign.center,), 
                                  textColor: Colors.black,
                                onPressed: (){
                                    Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => _RaportItem(
                                      list[index].val)));
                                  },
                                color: Colors.white,
                                height: 190.0,
                                minWidth: 135,
                                elevation: 5,
                              )
                          
                      ),
                    ),
      ],),
    );
  }

class _RaportItem extends StatefulWidget {
  String _img;

  _RaportItem(String s) {
    _img = s;
  }

  @override
  _RaportItemState createState() => _RaportItemState(_img);
}

class _RaportItemState extends State<_RaportItem> {
  String _img;
  _RaportItemState(String img) {
    _img = img;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoView(
      imageProvider: AssetImage(_img),
    ));
  }
}


Widget _dobovyiNariadItemBuilder(BuildContext context, List<ListDocumentsRaportItem> list, int index){
      return Container(
       padding: EdgeInsets.all(5.0),
    child:   Column(
        children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container( 
                            child: MaterialButton(
                              child: Text(list[index].name, textAlign: TextAlign.center,), 
                                textColor: Colors.black,
                                onPressed: (){ 
                                    Navigator.push( context, MaterialPageRoute( builder: (_) => 
                                   _NariadItem( list[index].val)));
                                  },
                                color: Colors.white,
                                height: 190.0,
                                minWidth: 135,
                                elevation: 5,
                              )
                          
                      ),
                    ),
      ],),
    );
}

class _NariadItem extends StatelessWidget {
  String _text;
  _NariadItem( String text){
    _text = text;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[200],
        leading: MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back, color: Colors.grey, size: 33.0,),
                ),
      ),
      body: SingleChildScrollView(
              child: Container(
                color: Colors.grey[200],
                child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(_text, style: TextStyle(fontSize: 16),),
        ),
              ),
      )
    );
  }
}







import 'package:dmb_timer_3/screens/shevrons/shevrons_list.dart';
import 'package:dmb_timer_3/menu/Menu.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';


class ShevronsScreen extends StatefulWidget {
  static const String id = "SHEVRONS_SCREEN";
  
  @override
  _ShevronsScreenState createState() => _ShevronsScreenState();
}

class _ShevronsScreenState extends State<ShevronsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
   double _width = MediaQuery.of(context).size.width;
   double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Шеврони ЗСУ', style: TextStyle(color: Colors.black87),),
        elevation: 0,
        leading: MaterialButton(
                  onPressed: () => _scaffoldKey.currentState.openDrawer(),
                  child: Icon(Icons.menu, color: Colors.grey, size: 33.0,),
                ),
        backgroundColor: Colors.white,
        ),
      drawer: Drawer(child: menu(context)),
      body: Container(
          height: _height,
          width: _width,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 0.0
            ), 
             scrollDirection: Axis.vertical,
             itemCount: shevronsList.length,
             itemBuilder: (BuildContext context, index) {
               return _shevronItem(context, shevronsList[index]);
             } 
            )
      )
    );
  }

  Widget _shevronItem(BuildContext context, ShevronListItem shevronItem){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: <Widget>[
       GestureDetector(
         onTap: (){
           showDialog(
             context: context,
             builder: (context) => _builPhotoView(context, shevronItem)
            );
         },
          child: Container(
            height: 120,
           width: 120,
           child: Image.asset(shevronItem.img)),
       ),
       Text(shevronItem.title),
      ],),
    );
  }

  Widget _builPhotoView(BuildContext context, ShevronListItem shevronItem){
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        Text(shevronItem.title),
        Text('фото взято з сайту symvolica.com.ua', style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, fontWeight: FontWeight.normal, color: Colors.grey[600]))
      ],),
      backgroundColor: Colors.white,
      content: Container(
        height: 336,
        width: 279,
      child: PhotoView(

        maxScale: 0.85,
        backgroundDecoration: BoxDecoration(
          color: Colors.white,
        ),
        imageProvider: AssetImage(shevronItem.img),
      )
    ),
      actions: <Widget>[
        MaterialButton(
          elevation: 3.0,
          child: Text('Закрити'),
          onPressed: (){
            Navigator.of(context).pop();
          },
        )
      ],      
    );    
  }
}
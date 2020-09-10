import 'package:cached_network_image/cached_network_image.dart';
import 'package:dmb_timer_3/utilities/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeBanner extends StatefulWidget {
  @override
  _HomeBannerState createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  String _imageUrl = '';
  String _launchUrlAddress = '';

 getFirebaseUrl() async {
    DataSnapshot imageUrl = await FirebaseDatabase.instance.reference().child(BANNER_DATABASE_NAME).once();
    DataSnapshot launchUrl = await FirebaseDatabase.instance.reference().child(LAUNCHURL_DATABASE_NAME).once();
    _launchUrlAddress = launchUrl.value;    
    setState(() {
    _imageUrl = imageUrl.value;
  
    });


 }

  @override
  void initState() {

     getFirebaseUrl();

    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
          Positioned(
            left: 5,
            bottom: 0,
            right: 5,
              child: Container(
                height: 90,
                width: 200,
                child: GestureDetector(
                onTapCancel: (){
                  setState(() {
                    _imageUrl = '';
                  });
                },
                onTap: launchURL,
                child: CachedNetworkImage(
                placeholder: (context, url) => null,
                imageUrl: _imageUrl,
                         ),
                        ),
              ),
          ),
    ],);
  }

  launchURL() async {
  String url = _launchUrlAddress;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
}


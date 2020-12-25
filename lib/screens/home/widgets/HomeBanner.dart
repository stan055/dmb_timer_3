import 'package:cached_network_image/cached_network_image.dart';
import 'package:dmb_timer_3/services/firebase.service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeBanner extends StatefulWidget {
  @override
  _HomeBannerState createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  String _imageUrl = '';
  String _launchUrlAddress = '';
  FirebaseService fire = new FirebaseService();

  getFirebaseUrl() async {
    _launchUrlAddress = await fire.getFirebaseLaunchUrl();
    _imageUrl = await fire.getFirebaseImgUrl();
    setState(() {});
  }

  @override
  void initState() {
    getFirebaseUrl();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: 5,
          bottom: 0,
          right: 5,
          child: Container(
            height: 90,
            width: 200,
            child: GestureDetector(
              onTapCancel: () {
                setState(() {
                  _imageUrl = '';
                });
              },
              onTap: launchURL,
              child: _imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      placeholder: (context, url) => null,
                      imageUrl: _imageUrl,
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
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

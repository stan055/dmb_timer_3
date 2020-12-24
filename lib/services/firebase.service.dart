import 'package:firebase_database/firebase_database.dart';
import 'package:dmb_timer_3/utilities/global_constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:dmb_timer_3/utilities/Pref.dart';

class FirebaseService {
  Future<String> getFirebaseLaunchUrl() async {
    DataSnapshot launchUrl = await FirebaseDatabase.instance
        .reference()
        .child(LAUNCHURL_DATABASE_NAME)
        .once();
    return launchUrl.value;
  }

  Future<String> getFirebaseImgUrl() async {
    DataSnapshot imageUrl = await FirebaseDatabase.instance
        .reference()
        .child(BANNER_DATABASE_NAME)
        .once();
    return imageUrl.value;
  }

  Future<String> getHomePageImgUrl() async {
    DataSnapshot homeImgUrl = await FirebaseDatabase.instance
        .reference()
        .child(HOME_PAGE_IMG_DATABASE)
        .once();
    return homeImgUrl.value;
  }

  Future<dynamic> getMeta(String name) async {
    await firebase_core.Firebase.initializeApp();
    try {
      var ref = firebase_storage.FirebaseStorage.instance.ref(name);
      return ref.getMetadata();
    } catch (e) {
      print(e);
    }
  }

  Future<void> downloadFile(int timeCreated) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    File downloadToFile = File('${appDocDir.path}/wallpaper.jpg');
    try {
      firebase_storage.FirebaseStorage.instance
          .ref('wallpaper.jpg')
          .writeToFile(downloadToFile)
          .whenComplete(
              () => {Pref.saveFile(downloadToFile.path, timeCreated)});
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }
}

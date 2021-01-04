import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'dart:convert';
import 'package:dmb_timer_3/utilities/global_constants.dart';
import 'package:path_provider/path_provider.dart';
import 'UserData.dart';

class Pref {
  static const String DATE_START_KEY = "DATE_START";
  static const String DATE_END_KEY = "DATE_END";
  static const String NICK_NAME_KEY = 'NICK_NAME';

  static Future<Object> getData() async {
    UserData data = new UserData();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    data.nickName = prefs.getString(NICK_NAME_KEY) ?? NICK_NAME;
    data.dateStart =
        prefs.getInt(DATE_START_KEY) ?? DateTime.now().millisecondsSinceEpoch;
    data.dateEnd =
        prefs.getInt(DATE_END_KEY) ?? DateTime.now().millisecondsSinceEpoch;

    return data;
  }

  static Future<int> getDateStartTimer() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(DATE_START_KEY) ?? null;
  }

  static Future<bool> saveDateStartTimer(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(DATE_START_KEY, value);
  }

  static Future<int> getDateEndTimer() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(DATE_END_KEY) ?? null;
  }

  static Future<bool> saveDateEndTimer(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(DATE_END_KEY, value);
  }

  static Future<int> getWallpapersTimeCreated() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(HOME_PAGE_IMG_DATECREATED);
  }

  static Future<bool> saveFile(String filePath, int timeCreated) async {
    final bytes = File(filePath).readAsBytesSync();
    String img64 = base64Encode(bytes);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(HOME_PAGE_IMG_DATECREATED, timeCreated);
    return prefs.setString(HOME_PAGE_IMG_DATABASE, img64);
  }

  static Future<File> getWallpaper() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String img64 = prefs.getString(HOME_PAGE_IMG_DATABASE);
      final decodedBytes = base64Decode(img64);
      Directory appDocDir = await getApplicationDocumentsDirectory();
      var file = File('${appDocDir.path}/wallpaper.jpg');
      file.writeAsBytesSync(decodedBytes);
      return file;
    } catch (e) {
      return null;
    }
  }

  static setNickName(nickname) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(NICK_NAME_KEY, nickname);
  }
}

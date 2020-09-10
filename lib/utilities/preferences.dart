import 'package:shared_preferences/shared_preferences.dart';


class Utility {
  //
  static const String DATE_START_KEY = "DATE_START_KEY";
  static const String DATE_START_END = "DATE_START_END";

 
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
    return prefs.getInt(DATE_START_END) ?? null;
  }
 
  static Future<bool> saveDateEndTimer(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(DATE_START_END, value);
  }
 
  // static Image imageFromBase64String(String base64String) {
  //   return Image.memory(
  //     base64Decode(base64String),
  //     fit: BoxFit.fill,
  //   );
  // }
 
  // static Uint8List dataFromBase64String(String base64String) {
  //   return base64Decode(base64String);
  // }
 
  // static String base64String(Uint8List data) {
  //   return base64Encode(data);
  // }
}
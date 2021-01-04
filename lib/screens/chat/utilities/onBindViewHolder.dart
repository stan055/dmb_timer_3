import 'package:quartet/quartet.dart';

List<String> onBindViewHolder(String text) {
  String msg = text;
  String name = "", message = "";
  bool boolName = true;
  for (int ii = 0; ii < msg.length; ii++) {
    if (boolName) {
      if (charAt(msg, ii) != '\n') {
        name += charAt(msg, ii);
      } else {
        boolName = false;
      }
    } else {
      message += charAt(msg, ii);
    }
  }

  List<String> ss = new List<String>(2);
  ss[0] = name;
  ss[1] = message;

  return ss;
}

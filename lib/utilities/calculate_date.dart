passedDay(int milliseconds) {
  int milisecondsOfOneDay = 86400000;
  int day = ((DateTime.now().millisecondsSinceEpoch - milliseconds) /
          milisecondsOfOneDay) ~/
      1;
  return day;
}

leftDay(int milliseconds) {
  int milisecondsOfOneDay = 86400000;
  int day = ((milliseconds - DateTime.now().millisecondsSinceEpoch) /
          milisecondsOfOneDay) ~/
      1;
  return day;
}

percentLeft(int start, int end) {
  return 100.0 - percentPassed(start, end);
}

percentPassed(int start, int end) {
  int timeLeft = (DateTime.now().millisecondsSinceEpoch - start).toInt();
  int timeStartEnd = (end - start).toInt();
  double percent = 100.0 / (timeStartEnd - 1) * timeLeft;

  if (percent < 100.0 && percent > 0.0)
    return percent;
  else
    return 0;
}

percentPassedPro(int start, int end, {bool boolPercent = false}) {
  double percent = percentPassed(start, end) * 1.0;
  if (!boolPercent) {
    if (percent >= 0.0 && percent <= 100.0)
      return percent;
    else if (percent >= 100.0) {
      return 100.0;
    } else
      return 0.0;
  } else {
    double value = (percent - percent % 10) / 100;
    if (value >= 0.0 && value <= 1.0) {
      return value;
    } else {
      return 0.0;
    }
  }
}

timeLeft(int timeEnd) {
  int milisecond = timeEnd - DateTime.now().millisecondsSinceEpoch;
  return milisecondToHourMinutSecond(milisecond);
}

timePassed(int dateStart) {
  int milisecond = DateTime.now().millisecondsSinceEpoch - dateStart;
  return milisecondToHourMinutSecond(milisecond);
}

milisecondToHourMinutSecond(int milisecond) {
  double dobleSecond = milisecond / 1000;

  int intHour = (dobleSecond / 60 ~/ 60);
  int intMinut = ((dobleSecond / 60) % 60).toInt();
  int second = (dobleSecond % 60).toInt();

  String s =
      intHour.toString() + ":" + intMinut.toString() + ":" + second.toString();

  return s;
}

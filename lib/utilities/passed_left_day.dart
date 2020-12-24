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

percentPassed(int start, int end) {
  int timeLeft = (DateTime.now().millisecondsSinceEpoch - start).toInt();
  int timeStartEnd = (end - start).toInt();
  double percent = 100.0 / (timeStartEnd - 1) * timeLeft;

  if (percent < 100.0 && percent > 0.0)
    return percent; //.toStringAsFixed(1);
  else
    return 0;
}

percentLeft(int start, int end) {
  int timeLeft = (DateTime.now().millisecondsSinceEpoch - start).toInt();
  int timeStartEnd = (end - start).toInt();
  double percent = 100.0 - (100.0 / (timeStartEnd - 1) * timeLeft);

  if (percent < 100.0 && percent > 0.0)
    return percent;
  else
    return 0;
}




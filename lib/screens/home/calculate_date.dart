double percentPassed(int start, int end, bool boolPercent) {
  int timeLeft = (DateTime.now().millisecondsSinceEpoch - start).toInt();
  int timeStartEnd = (end - start).toInt();
  double percent = 100.0 / (timeStartEnd - 1) * timeLeft;
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

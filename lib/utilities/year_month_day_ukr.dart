import 'write_year_month_day_ukr.dart';

String passedYearMonthDayUkr(int timeStart) {
  int timeNow = DateTime.now().millisecondsSinceEpoch - timeStart;
  return yearMonthDayUkr(timeNow);
}

String leftYearMonthDayUkr(int timeEnd) {
  int timeNow = timeEnd - DateTime.now().millisecondsSinceEpoch;
  return yearMonthDayUkr(timeNow);
}

yearMonthDayUkr(int timeNow) {
  double iyear, iday;

  iday = (timeNow / 1000 / 60 / 60 / 24);

  iyear = iday / 365;

  int yearleftOfCal = iyear.toInt();
  int monthLeftOfYear =
      ((iday / (365.0 / 12.0)) - (yearleftOfCal * 12)).toInt();
  int dayLeftOfMonth =
      (iday - (((yearleftOfCal * 12) + monthLeftOfYear) * 30.416666666666667))
          .toInt();

  List<String> sYearMonthDay = new List<String>(3);
  writeYearMonthDayUkr(
      sYearMonthDay, yearleftOfCal, monthLeftOfYear, dayLeftOfMonth);

  String year, month, day;
  if (yearleftOfCal < 1)
    year = "";
  else
    year = yearleftOfCal.toString() + ' ' + sYearMonthDay[0] + " ";

  if (monthLeftOfYear < 1)
    month = "";
  else
    month = monthLeftOfYear.toString() + ' ' + sYearMonthDay[1] + " ";

  if (dayLeftOfMonth < 1)
    day = " ";
  else
    day = dayLeftOfMonth.toString() + ' ' + sYearMonthDay[2];

  String ss;
  if (!(year == "" && month == "" && day == "")) {
    ss = year + month + day;
  } else
    ss = " ";

  return ss;
}

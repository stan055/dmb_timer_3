String timeFromDate() {
  DateTime _dateTime = DateTime.now();
  String minutes = _dateTime.minute < 10
      ? "0" + _dateTime.minute.toString()
      : _dateTime.minute.toString();
  return _dateTime.hour.toString() + ':' + minutes;
}

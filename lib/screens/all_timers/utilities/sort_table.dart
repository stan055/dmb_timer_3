import 'package:dmb_timer_3/utilities/calculate_date.dart';
import 'package:dmb_timer_3/screens/all_timers/utilities/Timer.dart';

onSortColum(int columnIndex, bool ascending, List<Timer> timers) {
  if (columnIndex == 4) {
    if (ascending) {
      timers.sort((a, b) => leftDay(a.end).compareTo(leftDay(b.end)));
    } else {
      timers.sort((a, b) => leftDay(b.end).compareTo(leftDay(a.end)));
    }
  } else if (columnIndex == 3) {
    if (ascending) {
      timers.sort((a, b) => passedDay(a.start).compareTo(passedDay(b.start)));
    } else {
      timers.sort((a, b) => passedDay(b.start).compareTo(passedDay(a.start)));
    }
  } else if (columnIndex == 1) {
    if (ascending) {
      timers.sort((a, b) => a.name.compareTo(b.name));
    } else {
      timers.sort((a, b) => b.name.compareTo(a.name));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:dmb_timer_3/utilities/global_var.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';

class ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (BuildContext context, double value, Widget child) {
        return RoundedProgressBar(
            childCenter: Text(PERCENT_VALUE.value.toStringAsFixed(1),
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            height: 12.0,
            childLeft: Text('progressBar'),
            milliseconds: 2000,
            style: RoundedProgressBarStyle(
                colorBorder: Colors.transparent,
                colorProgressDark: Colors.transparent,
                borderWidth: 0,
                backgroundProgress: Color(0x88f05059),
                colorProgress: Color(0x8840ffa1)),
            percent: PERCENT_VALUE.value);
      },
      valueListenable: PERCENT_VALUE,
    );
  }
}

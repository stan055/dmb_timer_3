import 'dart:io';
import 'package:flutter/material.dart';


int DATE_TIME_START = DateTime.now().millisecondsSinceEpoch;
int DATE_TIME_END = DateTime.now().millisecondsSinceEpoch;
String NICK_NAME_VAL = 'bro';
final ValueNotifier<double> PERCENT_VALUE = ValueNotifier<double>(0);

File homeScreenImg;
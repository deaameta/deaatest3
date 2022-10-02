import 'package:flutter/material.dart';

class DateTimeService {
  static double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;
}

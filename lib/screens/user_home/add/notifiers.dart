import 'package:flutter/material.dart';

class SwitchChanged extends Notification {
  final bool dept;
  final bool anon;
  SwitchChanged(
    this.dept,
    this.anon,
  );
}

class DateTimeChanged extends Notification {
  final DateTime date;
  final TimeOfDay time;
  DateTimeChanged(
    this.date,
    this.time,
  );
}

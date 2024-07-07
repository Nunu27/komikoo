import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final timeFormatter = DateFormat('H:mm');
final dateFormatter = DateFormat('MMMM d, y');
final shortDateFormatter = DateFormat('M/d/y');

extension TimeOfDayFormatter on TimeOfDay {
  String toTimeString() =>
      "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
}

extension PercentageDouble on double {
  String toPercentage() => (this * 100).toStringAsFixed(1);
}

extension TimeFormatter on DateTime {
  String toTimeString() => timeFormatter.format(this);
  String toDateString() => dateFormatter.format(this);
  String toShortDateString() => shortDateFormatter.format(this);
}

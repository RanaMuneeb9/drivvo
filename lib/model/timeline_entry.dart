import 'package:flutter/material.dart';

enum TimelineEntryType {
  refueling,
  expense,
  service,
  income,
  route,
  welcome,
}

class TimelineEntry {
  final TimelineEntryType type;
  final String title;
  final String odometer;
  final DateTime date;
  final String amount;
  final bool isIncome;
  final IconData icon;
  final Color iconBgColor;

  TimelineEntry({
    required this.type,
    required this.title,
    required this.odometer,
    required this.date,
    required this.amount,
    required this.isIncome,
    required this.icon,
    required this.iconBgColor,
  });

  // Format date as "dd MMM" (e.g., "17 dec")
  String get formattedDate {
    const months = [
      'jan', 'feb', 'mar', 'apr', 'may', 'jun',
      'jul', 'aug', 'sep', 'oct', 'nov', 'dec'
    ];
    return '${date.day.toString().padLeft(2, '0')} ${months[date.month - 1]}';
  }

  // Get month-year key for grouping (e.g., "DECEMBER 2025")
  String get monthYearKey {
    const months = [
      'JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE',
      'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }
}

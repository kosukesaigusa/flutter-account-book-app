import 'package:flutter/material.dart';

class CalendarWidgetModel extends ChangeNotifier {
  CalendarWidgetModel(this.year, this.month, this.day);
  int year;
  int month;
  int day;

  void onDateCellTapped(int number) {
    day = number;
    notifyListeners();
  }

  void showNextMonth() {
    final nextMonth = DateTime(year, month + 1);
    year = nextMonth.year;
    month = nextMonth.month;
    day = 1;
    notifyListeners();
  }

  void showPreviousMonth() {
    final previousMonth = DateTime(year, month - 1);
    year = previousMonth.year;
    month = previousMonth.month;
    day = 1;
    notifyListeners();
  }
}

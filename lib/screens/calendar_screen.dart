import 'package:flutter/material.dart';
import 'package:flutter_account_book_app/components/calendar/calendar.dart';

class CalendarScreen extends StatelessWidget {
  final today = DateTime.now();
  @override
  Widget build(BuildContext context) => Column(
        children: [
          CalendarWidget(today.year, today.month, today.day),
          // SingleChildScrollView(
          //   child: Text('支出一覧'),
          // ),
          // Text('2021年3月28日 (日)'),
        ],
      );
}

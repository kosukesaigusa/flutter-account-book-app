import 'package:flutter/material.dart';
import 'package:flutter_account_book_app/components/calendar/calendar.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          CalendarWidget(2021, 3),
          // SingleChildScrollView(
          //   child: Text('支出一覧'),
          // ),
          // Text('2021年3月28日 (日)'),
        ],
      );
}

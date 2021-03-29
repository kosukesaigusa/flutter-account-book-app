import 'package:flutter/material.dart';
import 'package:flutter_account_book_app/common/datetime.dart';
import 'package:flutter_account_book_app/common/text_style.dart';

class CalendarWidget extends StatelessWidget {
  CalendarWidget(this.year, this.month);
  final int year;
  final int month;
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: [
              const Expanded(child: SizedBox()),
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_outlined),
                onPressed: () {},
              ),
              Text('$year年 $month月'),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios_outlined),
                onPressed: () {},
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: weekdayRow(),
          ),
          calendar(year, month),
        ],
      );

  List<Widget> weekdayRow() {
    final list = <Widget>[];
    for (var i = 0; i < 7; i++) {
      list.add(
        Expanded(
          child: Container(
            color: Colors.grey[200],
            child: Center(child: Text('${weekdays[i]}')),
          ),
        ),
      );
    }
    return list;
  }

  Widget calendar(int year, int month) {
    final weekDayOfFirstDay = DateTime(year, month, 1).weekday;
    final lastDay = getLastDay(year, month);
    final numRows = ((weekDayOfFirstDay - 1 + lastDay) / 7).ceil();
    final columnChildren = <Widget>[];
    for (var i = 0; i < numRows; i++) {
      final weekRowChildren = <Widget>[];
      for (var j = 0; j < 7; j++) {
        final isValid = 1 <= (i * 7 + j + 1 - (weekDayOfFirstDay - 1)) &&
            (i * 7 + j + 1 - (weekDayOfFirstDay - 1)) <= lastDay;
        final dateCell = Expanded(
          child: Container(
            color: isValid ? Colors.transparent : Colors.grey[200],
            height: 80,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: isValid
                    ? [
                        Text('${i * 7 + j + 1 - (weekDayOfFirstDay - 1)}'),
                        Text(
                          '+ ¥2,000',
                          style: calendarTotalIncomeTextStyle,
                        ),
                        Text(
                          '- ¥1,500',
                          style: calendarTotalExpenseTextStyle,
                        ),
                      ]
                    : [],
              ),
            ),
          ),
        );
        weekRowChildren.add(dateCell);
      }
      columnChildren.add(Row(children: weekRowChildren));
    }
    return Column(children: columnChildren);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_account_book_app/common/datetime.dart';
import 'package:flutter_account_book_app/common/text_style.dart';
import 'package:flutter_account_book_app/components/calendar/calendar_model.dart';
import 'package:provider/provider.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget(this.year, this.month, this.day);
  final int year;
  final int month;
  final int day;
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => CalendarWidgetModel(year, month, day),
        child: Consumer<CalendarWidgetModel>(
          builder: (context, model, child) {
            return Column(
              children: [
                monthHandlingRow(context, model.year, model.month),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: weekdayRow(),
                ),
                calendar(context, model.year, model.month, model.day),
              ],
            );
          },
        ),
      );

  /// カレンダー上部の年月を表示・操作するウィジェット
  Widget monthHandlingRow(BuildContext context, int year, int month) {
    final model = Provider.of<CalendarWidgetModel>(context);
    return Row(
      children: [
        const Expanded(child: SizedBox()),
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            model.showPreviousMonth();
          },
        ),
        Text('$year年 $month月'),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios_outlined),
          onPressed: () {
            model.showNextMonth();
          },
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }

  /// カレンダー上部の月〜日の曜日を表示するウィジェット
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

  /// カレンダーウィジェット
  Widget calendar(BuildContext context, int year, int month, int day) {
    final model = Provider.of<CalendarWidgetModel>(context);
    final weekDayOfFirstDay = DateTime(year, month, 1).weekday;
    final lastDay = getLastDay(year, month);
    final numRows = ((weekDayOfFirstDay - 1 + lastDay) / 7).ceil();
    final columnChildren = <Widget>[];
    for (var i = 0; i < numRows; i++) {
      final weekRowChildren = <Widget>[];
      for (var j = 0; j < 7; j++) {
        final number = i * 7 + j + 1 - (weekDayOfFirstDay - 1);
        final isValid = 1 <= number && number <= lastDay;
        final dateCell = Expanded(
          child: Container(
            color: isValid
                ? day == number
                    ? Colors.amber[200]
                    : Colors.transparent
                : Colors.grey[200],
            height: 80,
            child: isValid
                ? InkWell(
                    onTap: () {
                      model.onDateCellTapped(number);
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('$number'),
                          Text(
                            '+ ¥2,000',
                            style: calendarTotalIncomeTextStyle,
                          ),
                          Text(
                            '- ¥1,500',
                            style: calendarTotalExpenseTextStyle,
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        );
        weekRowChildren.add(dateCell);
      }
      columnChildren.add(Row(children: weekRowChildren));
    }
    return Column(children: columnChildren);
  }
}

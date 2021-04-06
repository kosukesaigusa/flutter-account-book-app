import 'package:flutter/material.dart';
import 'package:flutter_account_book_app/common/datetime.dart';
import 'package:flutter_account_book_app/components/expense_add_form/expense_add_form.dart';
import 'package:flutter_account_book_app/models/models.dart';
import 'package:provider/provider.dart';

enum ExpenseIncomeActionType {
  addExpense,
  updateExpense,
  addIncome,
  updateIncome,
}

class ExpenseAddScreen extends StatelessWidget {
  const ExpenseAddScreen(
      {@required this.actionType,
      this.expense,
      this.income,
      this.year,
      this.month,
      this.day});
  final ExpenseIncomeActionType actionType;
  final Expense expense;
  final Income income;
  final int year;
  final int month;
  final int day;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ChangeNotifierProvider(
        create: actionType == ExpenseIncomeActionType.addExpense ||
                actionType == ExpenseIncomeActionType.updateExpense
            ? (_) => ExpenseAddScreenModel(
                expense: expense,
                actionType: actionType,
                year: year,
                month: month,
                day: day)
              ..init()
            : (_) =>
                ExpenseAddScreenModel(income: income, actionType: actionType)
                  ..init(),
        child: Consumer<ExpenseAddScreenModel>(
          builder: (context, model, child) => Padding(
            padding: const EdgeInsets.all(paddingWidth),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dateSection(context),
                dividerWidget,
                noteSection(context),
                dividerWidget,
                priceSection(context),
                dividerWidget,
                Expanded(child: categorySection(context)),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('支出/収入を 登録/更新'),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dateSection(BuildContext context) {
    final model = Provider.of<ExpenseAddScreenModel>(context);
    return SizedBox(
      height: inputFormHeight,
      child: Row(
        children: [
          const SizedBox(
            width: labelWidth,
            child: Text('日付'),
          ),
          const SizedBox(width: marginWidth),
          SizedBox(
            width: iconWidth,
            child: InkWell(
              onTap: () {
                model.showPreviousDay();
              },
              child: const Icon(Icons.arrow_back_ios),
            ),
          ),
          Container(
            color: Colors.amber[100],
            width: inputFormWidth(context),
            child: Center(
              child: Text(
                '${model.year}年 ${model.month}月 ${model.day}日'
                ' (${model.weekday})',
              ),
            ),
          ),
          SizedBox(
            width: iconWidth,
            child: InkWell(
              onTap: () {
                model.showNextDay();
              },
              child: const Icon(Icons.arrow_forward_ios),
            ),
          ),
        ],
      ),
    );
  }

  Widget noteSection(BuildContext context) {
    return SizedBox(
      height: inputFormHeight,
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: labelWidth,
            child: Text('メモ'),
          ),
          const SizedBox(width: marginWidth2),
          SizedBox(
            width: inputFormWidth(context),
            child: TextField(
              // focusNode: _focusNodeNote,
              onChanged: (text) {
                // model.changeNote(text);
              },
              minLines: 1,
              maxLines: 1,
              decoration: const InputDecoration(
                errorText: null,
                contentPadding: EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: 2,
                  bottom: 2,
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget priceSection(BuildContext context) {
    return SizedBox(
      height: inputFormHeight,
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: labelWidth,
            child: Text('値段'),
          ),
          const SizedBox(width: marginWidth2),
          SizedBox(
            width: inputFormWidth(context),
            child: TextField(
              keyboardType: TextInputType.number,
              // focusNode: _focusNodeNote,
              onChanged: (text) {
                // model.changeNote(text);
              },
              minLines: 1,
              maxLines: 1,
              decoration: const InputDecoration(
                errorText: null,
                contentPadding: EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: 2,
                  bottom: 2,
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget categorySection(BuildContext context) {
    final list = List.generate(
      100,
      (index) => Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fastfood),
            const SizedBox(height: 8),
            Text(
              '食費・栄養あああああああ',
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('カテゴリー'),
        Expanded(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: categoryCardWidth,
              ),
              itemCount: list.length,
              itemBuilder: (context, index) => list[index]),
        ),
      ],
    );
  }
}

class ExpenseAddScreenModel extends ChangeNotifier {
  ExpenseAddScreenModel(
      {@required this.actionType,
      this.expense,
      this.income,
      this.year,
      this.month,
      this.day});
  final ExpenseIncomeActionType actionType;
  final Expense expense;
  final Income income;
  int year;
  int month;
  int day;
  String weekday;
  String note;
  int price;
  int categoryId;

  void init() {
    if (actionType == ExpenseIncomeActionType.updateExpense) {
      year = expense.year;
      month = expense.month;
      day = expense.date;
      note = expense.note;
      price = expense.price;
      categoryId = expense.expense_category_id;
    }
    if (actionType == ExpenseIncomeActionType.updateIncome) {
      year = income.year;
      month = income.month;
      day = income.date;
      note = income.note;
      price = income.price;
      categoryId = income.income_category_id;
    }
    weekday = weekdays[getIntWeekDay(year, month, day) - 1];
    notifyListeners();
  }

  void showNextDay() {
    final nextDay = DateTime(year, month, day + 1);
    year = nextDay.year;
    month = nextDay.month;
    day = nextDay.day;
    weekday = weekdays[getIntWeekDay(year, month, day) - 1];
    notifyListeners();
  }

  void showPreviousDay() {
    final previousDay = DateTime(year, month, day - 1);
    year = previousDay.year;
    month = previousDay.month;
    day = previousDay.day;
    weekday = weekdays[getIntWeekDay(year, month, day) - 1];
    notifyListeners();
  }
}

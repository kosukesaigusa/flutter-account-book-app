import 'package:flutter/material.dart';
import 'package:flutter_account_book_app/ad_state.dart';
import 'package:flutter_account_book_app/components/calendar/calendar.dart';
import 'package:flutter_account_book_app/screens/expense_add_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final today = DateTime.now();
  BannerAd banner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        banner = BannerAd(
            // adUnitId: adState.bannerAdUnitId,
            adUnitId: adState.testBannerAdUnitId,
            size: AdSize.banner,
            request: const AdRequest(),
            listener: adState.adListener)
          ..load();
      });
    });
  }

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<CalendarScreenModel>(
        create: (_) => CalendarScreenModel(today.year, today.month, today.day),
        child: Consumer<CalendarScreenModel>(
          builder: (context, model, child) => Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: CalendarWidget(model.year, model.month, model.day),
                ),
                banner == null
                    ? const SizedBox(height: 50)
                    : SizedBox(
                        height: 50,
                        child: AdWidget(
                          ad: banner,
                        ),
                      ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              heroTag: 'calendar-screen-fab',
              onPressed: () async {
                // await insertFixedFees();
                await Navigator.push<void>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExpenseAddScreen(
                      actionType: ExpenseIncomeActionType.addExpense,
                      year: model.year,
                      month: model.month,
                      day: model.day,
                    ),
                    fullscreenDialog: true,
                  ),
                );
              },
              tooltip: '支出を登録',
              child: const Icon(Icons.add),
            ),
          ),
        ),
      );
}

class CalendarScreenModel extends ChangeNotifier {
  CalendarScreenModel(this.year, this.month, this.day);
  int year;
  int month;
  int day;
  BannerAd banner;

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

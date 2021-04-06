import 'package:flutter/material.dart';
import 'package:flutter_account_book_app/models/models.dart';
import 'package:flutter_account_book_app/screens/analytics_screen.dart';
import 'package:flutter_account_book_app/screens/calendar_screen.dart';
import 'package:flutter_account_book_app/screens/category_screen.dart';
import 'package:flutter_account_book_app/screens/fixed_fee_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final items = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today),
      label: 'カレンダー',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.repeat),
      label: '固定費',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.category),
      label: 'カテゴリー',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.analytics),
      label: '分析',
    ),
  ];

  final tabs = <Widget>[
    CalendarScreen(),
    FixedFeeScreen(),
    CategoryScreen(),
    AnalyticsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              await FixedFeeScreenModel().fetchFixedFees();
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          IndexedStack(
            index: currentIndex,
            children: tabs,
          ),
        ],
      ),
      bottomNavigationBar: bottomNavigator(context),
    );
  }

  Widget bottomNavigator(BuildContext context) {
    return BottomNavigationBar(
      items: items,
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        if (currentIndex != index) {
          setState(() {
            currentIndex = index;
          });
        }
      },
    );
  }
}

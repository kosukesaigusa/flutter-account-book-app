import 'package:flutter/material.dart';
import 'package:flutter_account_book_app/screens/analytics_screen.dart';
import 'package:flutter_account_book_app/screens/calendar_screen.dart';
import 'package:flutter_account_book_app/screens/category_screen.dart';
import 'package:flutter_account_book_app/screens/fixed_fee_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;
  int _currentIndex = 0;

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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: <Widget>[
          IndexedStack(
            index: _currentIndex,
            children: tabs,
          ),
        ],
      ),
      bottomNavigationBar: _bottomNavigator(context),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _bottomNavigator(BuildContext context) {
    return BottomNavigationBar(
      items: items,
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        if (_currentIndex != index) {
          setState(() {
            _currentIndex = index;
          });
        }
      },
    );
  }
}

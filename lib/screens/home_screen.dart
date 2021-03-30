import 'package:flutter/material.dart';
import 'package:flutter_account_book_app/screens/analytics_screen.dart';
import 'package:flutter_account_book_app/screens/calendar_screen.dart';
import 'package:flutter_account_book_app/screens/category_screen.dart';
import 'package:flutter_account_book_app/screens/fixed_fee_screen.dart';

import '../models/models.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
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
        onPressed: () async {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
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

  Future<void> insertFixedFees() async {
    final now = DateTime.now();
    final fixedFees = <Map<String, dynamic>>[
      <String, dynamic>{
        'name': '家賃',
        'price': 90330,
        'payment_cycle_id': 1,
        'note': '',
        'priority': 1,
        'created_at': now,
      },
      <String, dynamic>{
        'name': '電気',
        'price': 7000,
        'payment_cycle_id': 1,
        'note': '',
        'priority': 2,
        'created_at': now,
      },
      <String, dynamic>{
        'name': '水道',
        'price': 2000,
        'payment_cycle_id': 1,
        'note': '',
        'priority': 3,
        'created_at': now,
      },
      <String, dynamic>{
        'name': 'LINE モバイル',
        'price': 2000,
        'payment_cycle_id': 1,
        'note': '',
        'priority': 4,
        'created_at': now,
      },
      <String, dynamic>{
        'name': 'en ひかり',
        'price': 3828,
        'payment_cycle_id': 1,
        'note': '',
        'priority': 5,
        'created_at': now,
      },
      <String, dynamic>{
        'name': 'Flutter 大学',
        'price': 2200,
        'payment_cycle_id': 1,
        'note': '',
        'priority': 6,
        'created_at': now,
      },
      <String, dynamic>{
        'name': 'YouTube Premium',
        'price': 1180,
        'payment_cycle_id': 1,
        'note': '',
        'priority': 7,
        'created_at': now,
      },
      <String, dynamic>{
        'name': 'Amazon Gold カード',
        'price': 4400,
        'payment_cycle_id': 12,
        'note': '加入日：2019年6月5日。年会費の支払いは毎年7月の請求。'
            '元の11,000円から、マイペイリスボで5,500円、'
            'Web 明細で1,100円の割引により、合計4,400円。',
        'priority': 8,
        'created_at': now,
      },
      <String, dynamic>{
        'name': 'Apple Developer Program',
        'price': 12980,
        'payment_cycle_id': 12,
        'note': '加入日：2020年9月5日。11,800円+税 = 12,980円',
        'priority': 9,
        'created_at': now,
      },
      <String, dynamic>{
        'name': '1Password',
        'price': 4500,
        'payment_cycle_id': 12,
        'note': '支払日：毎年5月24日。'
            '2.99ドル/月（年払い）× 12ヶ月 × 1.10（消費税） = 39.47ドル ≒ 4500円',
        'priority': 10,
        'created_at': now,
      },
      <String, dynamic>{
        'name': 'Google Domains',
        'price': 1540,
        'payment_cycle_id': 12,
        'note': '毎年1月30日に更新。1,400円+税 = 1,540円',
        'priority': 11,
        'created_at': now,
      },
    ]..forEach((element) async {
        await FixedFee(
          name: element['name'].toString(),
          price: element['price'] as int,
          payment_cycle_id: element['payment_cycle_id'] as int,
          note: element['note'].toString(),
          priority: element['priority'] as int,
          created_at: element['created_at'] as DateTime,
        ).save();
      });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_account_book_app/common/theme.dart';
import 'package:flutter_account_book_app/screens/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        // スライダーのテーマ
        sliderTheme: const SliderThemeData(
          valueIndicatorColor: greyColor,
          inactiveTickMarkColor: Colors.grey,
          activeTickMarkColor: Colors.orange,
          inactiveTrackColor: Colors.grey,
        ),
      ),
      debugShowCheckedModeBanner: true,
      // home: HomeScreen(title: 'Flutter Demo Home Page'),
      routes: {
        '/': (context) => const HomeScreen(title: 'Flutter Demo Home Page'),
        // 'expense-add': (context) => ExpenseAddScreen(),
      },
    );
  }
}

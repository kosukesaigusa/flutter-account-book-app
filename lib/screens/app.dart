import 'package:flutter/material.dart';
import 'package:flutter_account_book_app/screens/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: true,
      home: HomeScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

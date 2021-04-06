import 'package:flutter/material.dart';
import 'package:flutter_account_book_app/ad_state.dart';
import 'package:flutter_account_book_app/screens/app.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);
  runApp(
    Provider.value(
      value: adState,
      builder: (context, child) => App(),
    ),
  );
}

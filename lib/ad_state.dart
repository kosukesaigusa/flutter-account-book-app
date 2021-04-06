import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  AdState(this.initialization);
  Future<InitializationStatus> initialization;

  String get testBannerAdUnitId => Platform.isAndroid
      // テスト用の ad unit ID
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  String get bannerAdUnitId => Platform.isAndroid
      // テスト用の ad unit ID
      ? 'ca-app-pub-9182145423129025/3814406097'
      : 'ca-app-pub-9182145423129025/9805099371';

  AdListener get adListener => _adListener;

  final AdListener _adListener = AdListener(
    onAdLoaded: (ad) => print('Ad loaded: ${ad.adUnitId}'),
    onAdClosed: (ad) => print('Ad closed: ${ad.adUnitId}'),
    onAdFailedToLoad: (ad, error) =>
        print('Ad failed to load: ${ad.adUnitId}, $error'),
    onAdOpened: (ad) => print('Ad opened: ${ad.adUnitId}'),
    onAppEvent: (ad, name, data) =>
        print('App event: ${ad.adUnitId}, $name, $data'),
    onApplicationExit: (ad) => print('App Exit: ${ad.adUnitId}'),
    onNativeAdClicked: (nativeAd) =>
        print('Native ad clicked: ${nativeAd.adUnitId}'),
    onNativeAdImpression: (nativeAd) =>
        print('Native ad impression: ${nativeAd.adUnitId}'),
    onRewardedAdUserEarnedReward: (ad, reward) =>
        print('User rewarded: ${ad.adUnitId}, ${reward.amount} ${reward.type}'),
  );
}

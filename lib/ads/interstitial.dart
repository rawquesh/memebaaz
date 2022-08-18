import 'dart:math';

// import 'package:meme_baaz/ads/const.dart';
// import 'package:native_admob_flutter/native_admob_flutter.dart';
// 
// import 'package:facebook_audience_network/facebook_audience_network.dart';

Future<void> showInterstitialAds([int max = 2]) async {
  if (Random().nextInt(max) == 0) {
    // final interstitialAd = InterstitialAd(unitId: AdsService.interstitial);
    // await interstitialAd.load(force: true, keywords: AdsService.adsRequest.keywords!, unitId: AdsService.interstitial);
    // if (interstitialAd.isAvailable) {
    //   await interstitialAd.show();
    // }

    // await FacebookAudienceNetwork.init(testingId: 'a77955ee-3304-4635-be65-81029b0f5201');

    // await FacebookInterstitialAd.loadInterstitialAd(
    //   placementId: '429732795171881_429734561838371',
    //   listener: (result, value) {
    //     if (result == InterstitialAdResult.LOADED) FacebookInterstitialAd.showInterstitialAd(delay: 1000);
    //   },
    // );
  }
}

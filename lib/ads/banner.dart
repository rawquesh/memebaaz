// import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
// import 'package:meme_baaz/ads/const.dart';
// import 'package:meme_baaz/constant/theme.dart';
// import 'package:native_admob_flutter/native_admob_flutter.dart';

class BannerAdsView extends StatefulWidget {
  const BannerAdsView({Key? key}) : super(key: key);

  @override
  _BannerAdsViewState createState() => _BannerAdsViewState();
}

class _BannerAdsViewState extends State<BannerAdsView> {
  // final controller = NativeAdController(unitId: AdsService.native);

  @override
  void initState() {
    // controller.load(keywords: AdsService.adsRequest.keywords!, unitId: AdsService.native);
    super.initState();
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // const _height = 60.0;
    // return NativeAd(
    //   controller: controller,
    //   unitId: AdsService.native,
    //   height: _height,
    //   builder: (context, child) {
    //     return Material(child: child);
    //   },
    //   buildLayout: adBannerLayoutBuilder, // smallAdTemplateLayoutBuilder
    //   loading: const SizedBox(
    //     height: _height,
    //     child: Center(child: Text('showing advertisement here')),
    //   ),
    //   nonPersonalizedAds: false,
    //   error: const SizedBox(
    //     height: _height,
    //     child: Center(child: Text('unable to load Ad')),
    //   ),
    //   icon: AdImageView(padding: const EdgeInsets.only(left: 6)),
    //   headline: AdTextView(style: const TextStyle(color: Colors.black)),
    //   advertiser: AdTextView(style: const TextStyle(color: Colors.black)),
    //   body: AdTextView(style: const TextStyle(color: Colors.black), maxLines: 1),
    //   media: AdMediaView(height: _height, width: 140),
    //   button: AdButtonView(
    //     height: _height,
    //     decoration: AdDecoration(borderRadius: AdBorderRadius.all(5), backgroundColor: Colors.white),
    //     margin: const EdgeInsets.only(left: 6, right: 6),
    //     textStyle: const TextStyle(color: themeColor, fontSize: 14),
    //     elevation: 0,
    //     elevationColor: themeColor,
    //     pressColor: themeColor3,
    //   ),
    // );
    return SizedBox.shrink();
    // return Container(
    // alignment: Alignment(0.5, 1),
    // child: FacebookBannerAd(
    //   placementId:  '429732795171881_429734448505049',
    //   bannerSize: BannerSize.STANDARD,
    //   listener: (result, value) {
    //     switch (result) {
    //       case BannerAdResult.ERROR:
    //         print('Error: $value');
    //         break;
    //       case BannerAdResult.LOADED:
    //         print('Loaded: $value');
    //         break;
    //       case BannerAdResult.CLICKED:
    //         print('Clicked: $value');
    //         break;
    //       case BannerAdResult.LOGGING_IMPRESSION:
    //         print('Logging Impression: $value');
    //         break;
    //     }
    //   },
    // ),
    // );
  }
}

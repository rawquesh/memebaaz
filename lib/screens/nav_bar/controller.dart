// import 'package:flutter/animation.dart';
import 'dart:async';

// import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_baaz/ads/interstitial.dart';
import 'package:meme_baaz/screens/bookmark/controller.dart';
import 'package:meme_baaz/screens/player/will_pop.dart';
import 'package:meme_baaz/screens/upload/controller.dart';
import 'package:meme_baaz/utils/scroll_to_top.dart';

class MyNavBarController extends GetxService {
  // ignore: prefer_final_fields
  RxInt _index = 0.obs;
  RxBool showFab = false.obs;
  final Rx<ScrollController> scrollController = ScrollController().obs;

  int get index => _index.value;

  set index(int value) {
    if (_index.value == 2 && value != 2) {
      Get.delete<BookmarkController>();
    }
    if (_index.value == 1 && value != 1) {
      Get.delete<UploadController>();
    }
    if (_index.value == 0 && value == 0) {
      final position = scrollController.value.position.pixels;
      if (position > 350) {
        scrollToTop(scrollController.value);
      }
    }
    _index.value = value;
    showInterstitialAds(5);
  }

  Future<bool> willpopscope() async {
    if (_index.value == 2) {
      // ignore: unawaited_futures
      Get.delete<BookmarkController>();
    }
    if (_index.value == 1) {
      // ignore: unawaited_futures
      Get.delete<UploadController>();
    }
    if (_index.value != 0) {
      _index.value = 0;
    }
    if (scrollController.value.position.pixels < 350) {
      await onBackPressed(Get.context!);
    } else {
      await scrollToTop(scrollController.value);
    }
    return false;
  }

  @override
  void onInit() {
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels > 350) {
        showFab.value = true;
      } else {
        showFab.value = false;
      }
    });
    setTestDevices();
    super.onInit();
  }

  Future<void> setTestDevices() async {
    // await FacebookAudienceNetwork.init(testingId: '88907077-a581-4eb3-a37b-e9a9500db5be');
  }
}

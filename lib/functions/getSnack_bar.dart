// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../constant/style.dart';
import '../constant/theme.dart';

Future<void> showToast({required String msg, bool short = true}) async {
  await Fluttertoast.cancel();
  await Fluttertoast.showToast(
    msg: msg,
    toastLength: short ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

void getSnackLoader([String msg = 'Please wait!']) {
  if (Get.isSnackbarOpen) {
    Get.back();
  }
  Get.snackbar(
    'Loading',
    msg,
    titleText: Text('Loading', style: ptSansFont().copyWith(fontWeight: FontWeight.bold, color: themeColor3)),
    messageText: Text(msg, style: ptSansFont().copyWith(color: themeColor3)),
    margin: EdgeInsets.all(10),
    colorText: Colors.blue[900],
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    reverseAnimationCurve: Curves.fastLinearToSlowEaseIn,
    duration: const Duration(minutes: 5),
    isDismissible: false,
    backgroundGradient: myLinearGradient,
    // borderRadius: 4,
    // icon: Padding(
    //   padding: const EdgeInsets.only(left: 20,right: 10),
    //   child: CupertinoActivityIndicator(radius: 10),
    // ),
    overlayBlur: 2,
    barBlur: 15,

    snackPosition: SnackPosition.BOTTOM,
  );
}

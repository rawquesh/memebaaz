import 'package:flutter/material.dart' show Route, Widget;
import 'package:get/get.dart';

void getNavigation(Widget widget) {
  Get.to(
    widget,
    transition: Transition.cupertino,
    duration: const Duration(milliseconds: 450),
    popGesture: true,
    preventDuplicates: false,
  );
}

// void getNavigationwithoutanim(Widget widget) {
//   Get.to(
//     () => widget,
//     transition: Transition.fadeIn,
//     duration: Duration(milliseconds: 500),
//     popGesture: true,
//     fullscreenDialog: true,
//   );
// }

void getNavigation2(Widget widget) {
  Get.offAll(
    () => widget,
    popGesture: true,
    predicate: (Route<dynamic> route) => false,
    transition: Transition.cupertino,
    duration: const Duration(milliseconds: 500),
  );
}

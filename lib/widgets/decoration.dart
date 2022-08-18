import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_baaz/constant/style.dart';

BoxDecoration buildDecoration({double? radius, Color? color}) {
  return BoxDecoration(
    color: Get.theme.scaffoldBackgroundColor,
    borderRadius: BorderRadius.circular(radius ?? myFontSize(35)),
    boxShadow: [
      BoxShadow(
        color: color ?? Colors.grey.withOpacity(0.10),
        offset: const Offset(1.1, 1.1),
        blurRadius: 10.0,
      ),
    ],
  );
}

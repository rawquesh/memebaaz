import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

double myFontSize(double fontSize) => ((((fontSize / Get.width) + (fontSize / Get.height)) / 3) + (fontSize / 10)) * 10;

double get screenHeight => Get.height;

double get screenWidth => Get.width;

// ignore: deprecated_member_use
TextStyle ptSansFont([double size = 15.1]) => GoogleFonts.ptSans(fontSize: myFontSize(size), letterSpacing: 0.2, color: Get.theme.accentColor);

SizedBox sizedBoxH(double height) => SizedBox(height: (height * 500) / Get.height);

SizedBox sizedBoxW(double width) => SizedBox(width: (width * 500) / Get.height);
// SizedBox sizedBoxP(double size) => SizedBox(width: myFontSize(size));

const noImageUrl = 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png';
const noImageUrlShop = 'https://storage.googleapis.com/possystem-db408.appspot.com/profile/Z3iIXX2GE9bApl4MNHiTKPKmgKG2/image_picker4696987569345710534.png';
const hashString = 'UGMaCiysX#v0%1?bR*t8C6rX+wFGX9xuf5Rj';

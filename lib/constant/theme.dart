// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meme_baaz/constant/style.dart';

final dartThemeData = ThemeData.dark().copyWith(
  splashColor: Colors.transparent,
  brightness: Brightness.dark,
  hintColor: Colors.black,
  // scaffoldBackgroundColor: Colors.black26,
  iconTheme: IconThemeData(color: Colors.white, size: myFontSize(25)), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
);
final lightThemeData = ThemeData.light().copyWith(
  scaffoldBackgroundColor: Colors.white,
  canvasColor: const Color(0xFFD0FFFF),
  hintColor: Colors.black,
  iconTheme: IconThemeData(color: Colors.black, size: myFontSize(25)),
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    iconTheme: IconThemeData(color: Colors.black12),
  ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black87),
);

const themeColor = Color(0xff3D79F4);

const Color themeColor3 = Color(0xFF09126C);

const myLinearGradient = LinearGradient(colors: [themeColor, themeColor3]);

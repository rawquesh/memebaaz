import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meme_baaz/constant/theme.dart';
import 'package:meme_baaz/screens/nav_bar/view.dart';

import 'constant/keys.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await GetStorage.init();
  manageStorage();
  await FirebaseAuth.instance.signInAnonymously();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      enableLog: false,
      debugShowCheckedModeBanner: false,
      title: 'Meme baaz',
      darkTheme: dartThemeData,
      themeMode: _setTheme(),
      theme: lightThemeData,
      home: MyNavBar(),
    );
  }
}

ThemeMode _setTheme() {
  final box = GetStorage();
  final v = box.read<bool>(StorageKeys.theme);
  if (v!) {
    return ThemeMode.dark;
  } else {
    return ThemeMode.light;
  }
}

void manageStorage() {
  final box = GetStorage();
  if (box.read(StorageKeys.like) == null) {
    box.write(StorageKeys.like, ['0']);
  }
  if (box.read(StorageKeys.save) == null) {
    box.write(StorageKeys.save, ['0']);
  }
  if (box.read(StorageKeys.theme) == null) {
    box.write(StorageKeys.theme, false);
  }
}

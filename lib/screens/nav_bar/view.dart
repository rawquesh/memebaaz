import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:animations/animations.dart';
import 'package:meme_baaz/constant/style.dart';
import 'package:meme_baaz/constant/theme.dart';
import 'package:meme_baaz/screens/aboutUs/view.dart';
import 'package:meme_baaz/screens/bookmark/view.dart';
import 'package:meme_baaz/screens/home/view.dart';
import 'package:meme_baaz/screens/upload/view.dart';
// import 'package:meme_baaz/screens/home/view2.dart';
// import 'package:meme_baaz/screens/upload/view.dart';

import 'controller.dart';

class MyNavBar extends StatelessWidget {

  final MyNavBarController controller = Get.put<MyNavBarController>(MyNavBarController());

  List<Widget> get _screens => [const HomePage(), const UploadPage(), const Bookmarks(), const AboutPage()];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.willpopscope,
      child: Obx(
        () => Scaffold(
          body: PageTransitionSwitcher(
            duration: const Duration(milliseconds: 150),
            transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
              return FadeThroughTransition(
                animation: primaryAnimation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
            child: _screens[controller.index],
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Get.theme.colorScheme.secondary,
            fixedColor: themeColor,
            elevation: 5,
            currentIndex: controller.index,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            selectedLabelStyle: ptSansFont(12.5),
            unselectedLabelStyle: ptSansFont(11),
            onTap: (int value) => controller.index = value,
            items: [
              navItems(LineIcons.home, 'Home'),
              navItems(Icons.file_upload_outlined, 'Upload'),
              navItems(LineIcons.bookmark, 'Saved'),
              navItems(LineIcons.infoCircle, 'More'),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem navItems(IconData icon, String label) => BottomNavigationBarItem(
        icon: Icon(icon, size: myFontSize(24)),
        label: label,
      );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:meme_baaz/admin/content/view.dart';
import 'package:meme_baaz/constant/style.dart';
import 'package:meme_baaz/constant/theme.dart';
import 'package:meme_baaz/functions/get_navigation.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Admin Page', style: ptSansFont(18).copyWith(letterSpacing: 1)),
      ),
      body: ListView(
        padding: EdgeInsets.all(myFontSize(5)),
        children: [
          Row(
            children: [
              _item(LineIcons.photoVideo, 'Content', const ContentPageAdmin()),
              _item(LineIcons.alternateLevelUp, 'Coming Soon', null),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _item(IconData icon, String text1, Widget? widget) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.all(myFontSize(5)),
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      // decoration: buildDecoration(radius: 10, color: Colors.grey.withOpacity(.25)),
      height: myFontSize(120),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: BorderRadius.circular(myFontSize(5)),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () async {
            if (widget == null) return;
            await Future.delayed(const Duration(milliseconds: 100));
            getNavigation(widget);
          },
          child: Column(
            children: [
              const Spacer(flex: 100),
              Icon(
                icon,
                size: myFontSize(25),
                color: themeColor,
              ),
              const Spacer(flex: 30),
              Text(text1, textAlign: TextAlign.center, style: ptSansFont(16).copyWith(color: themeColor)),
              const Spacer(flex: 100),
            ],
          ),
        ),
      ),
    ),
  );
}

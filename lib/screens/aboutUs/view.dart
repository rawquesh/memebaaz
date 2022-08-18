// import 'package:pos_system/admin/main/view.dart';
import 'package:get_storage/get_storage.dart';
import 'package:line_icons/line_icons.dart';
import 'package:meme_baaz/admin/functions/key_field.dart';
import 'package:meme_baaz/constant/keys.dart';
import 'package:meme_baaz/constant/style.dart';
import 'package:meme_baaz/constant/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' show FontAwesomeIcons;
import 'package:meme_baaz/functions/getSnack_bar.dart';
import 'package:meme_baaz/screens/aboutUs/faq.dart';
// import 'package:meme_baaz/screens/bookmark/view.dart';
// import 'package:meme_baaz/screens/upload/view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({
    Key? key,
  }) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final box = GetStorage();

  bool isDark = false;

  @override
  void initState() {
    isDark = box.read<bool>(StorageKeys.theme) ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ptSansFont2 = ptSansFont();
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          () {
            final imageSize = myFontSize(73);
            return Stack(
              // alignment: Alignment.center,
              children: [
                Container(
                  // padding: EdgeInsets.only(top: Get.mediaQuery.padding.top),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/bg.jpg'),
                      fit: BoxFit.cover,
                    ),
                    // gradient: myLinearGradient,
                  ),
                  height: myFontSize(110 + myFontSize(40) + Get.mediaQuery.padding.top),
                  child: Opacity(
                    opacity: 0.5,
                    child: Container(
                      padding: EdgeInsets.only(top: Get.mediaQuery.padding.top),
                      decoration: const BoxDecoration(gradient: myLinearGradient),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: Get.mediaQuery.padding.top,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Material(
                      type: MaterialType.transparency,
                      child: IconButton(
                        color: themeColor3,
                        onPressed: () => showKeyField(context),
                        icon: const Icon(LineIcons.appStore),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: Get.mediaQuery.padding.top + myFontSize(10), left: myFontSize(19)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              color: themeColor.withOpacity(.2),
                              padding: const EdgeInsets.all(3),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset('assets/new.jpg', height: imageSize, width: imageSize),
                              ),
                            ),
                          ),
                        ],
                      ),
                      sizedBoxH(7),
                      Text('Memebaazz', style: ptSansFont().copyWith(color: Colors.white, letterSpacing: 1)),
                    ],
                  ),
                ),
              ],
            );
          }(),
          sizedBoxH(20),
          ListTile(
            leading: Icon(LineIcons.sunAlt, color: Get.theme.colorScheme.secondary),
            title: Text('Dark Mode', style: ptSansFont2),
            trailing: Switch(
              value: isDark,
              onChanged: (v) {
                isDark = v;
                setState(() {});
                box.write(StorageKeys.theme, v);
                showToast(msg: 'Please re-launch the app');
              },
            ),
          ),
          sizedBoxH(20),
          ListTile(
            leading: Icon(LineIcons.questionCircle, color: Get.theme.colorScheme.secondary),
            onTap: () => showFAQs(context),
            title: Text("FAQ's", style: ptSansFont2),
          ),
          ListTile(
            leading: Icon(LineIcons.googlePlay, color: Get.theme.colorScheme.secondary),
            onTap: () async {
              const url = 'https://play.google.com/store/apps/details?id=com.memebaaz.MemeBaaz';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            title: Text('Rate the app', style: ptSansFont2),
          ),
          ListTile(
            leading: Icon(Icons.share_outlined, color: Get.theme.colorScheme.secondary),
            onTap: () {
              WcFlutterShare.share(
                sharePopupTitle: 'Share',
                subject: 'MemeBaaz',
                text: 'MemeBaaz is great app for daily new Memes and Short Vidoes, Download now : https://memebaaz.page.link/share',
                mimeType: 'text/plain',
              );
            },
            title: Text('Share', style: ptSansFont2),
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.instagram, color: Color(0xFFe4405f)),
            onTap: () async {
              const url = 'https://www.instagram.com/rawquesh/';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            title: Text('Follow on instagram', style: ptSansFont2),
          ),
        ],
      ),
    );
  }
}

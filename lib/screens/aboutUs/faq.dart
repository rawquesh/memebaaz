import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_baaz/constant/style.dart';
import 'package:meme_baaz/constant/theme.dart';

void showFAQs(BuildContext context) {
  showCupertinoDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      final ptSans2 = ptSansFont(14.2);
      final title = (String t) => Text(t, style: ptSans2.copyWith(color: Get.theme.colorScheme.secondary, fontWeight: FontWeight.w600));
      final detail = (String t) => Text(t, style: ptSansFont().copyWith(color: Get.theme.colorScheme.secondary.withOpacity(.6)));
      var sizedBoxH2 = sizedBoxH(25);
      return AlertDialog(
        title: Text("FAQ's Page", style: ptSans2.copyWith(fontWeight: FontWeight.bold)),
        scrollable: true,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            title('Why MemeBaaz...?'),
            detail(
              "Because we provide better content and always fresh and new with great UI design and smooth interface also we pick memes and funny stuff from all over the internet and social media so you'll get as you want just from one app 😍.",
            ),
            sizedBoxH2,
            sizedBoxH2,
            title('Need improvement or facing issue...?'),
            detail(
              'We are trying to improve thing but we need your feedback so please if you need new features or improvements then go to the play store and give us feedback 🙏.',
            ),
            sizedBoxH2,
            sizedBoxH2,
            title('Why advertisement...?'),
            detail(
              'We need funds to pay for server maintenance and need to keep the application alive 😥.',
            ),
            sizedBoxH2,
            sizedBoxH2,
            title('New content updates?'),
            detail(
              'We keep updating our content every 2,3 hour if all things are working and if some trouble  comes then maybe it can take 1 day but not more than that and anyone can upload memes so you will always see fresh content 😉.',
            ),
            sizedBoxH2,
            sizedBoxH2,
            title('Disclaimer'),
            detail(
              'All the images and assets provided in this app are taken from all over the internet and the owner of this app does not hold any rights so feel free to contact us for removing any material.',
            ),
            sizedBoxH2,
            sizedBoxH2,
            title('Email.'),
            detail('bluetouchdev@gmail.com'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK', style: ptSans2.copyWith(color: themeColor)),
          ),
        ],
      );
    },
  );
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_baaz/constant/style.dart';
import 'package:meme_baaz/constant/theme.dart';

void showUploadPrivacyPolicy(BuildContext context) {
  showCupertinoDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      final ptSans2 = ptSansFont(14.2);
      // ignore: deprecated_member_use
      final title = (String t) => Text(t, style: ptSans2.copyWith(color: Get.theme.accentColor, fontWeight: FontWeight.w600));
      // ignore: deprecated_member_use
      final detail = (String t) => Text(t, style: ptSansFont().copyWith(color: Get.theme.accentColor.withOpacity(.6)));
      var sizedBoxH2 = sizedBoxH(25);
      return AlertDialog(
        title: Text('PRIVACY & POLICY', style: ptSans2.copyWith(fontWeight: FontWeight.bold)),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            title('Size limit?'),
            detail('Max asset size 5MB.'),
            sizedBoxH2,
            sizedBoxH2,
            title('What to upload?'),
            detail('memes and funny short videos.'),
            sizedBoxH2,
            sizedBoxH2,
            title('What to not upload?'),
            detail('adult and sexual content.'),
            sizedBoxH2,
            sizedBoxH2,
            title('Availability'),
            detail('Every asset will go through a verification process by admin before publicly available.'),
            sizedBoxH2,
            sizedBoxH2,
            title('Why whould we even upload?'),
            detail('it\'s hard to find unique content for us so if you have something funny upload it here so the app will keep running.'),
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

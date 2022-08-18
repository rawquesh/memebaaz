import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:meme_baaz/constant/style.dart';
import 'package:meme_baaz/constant/theme.dart';
import 'package:meme_baaz/models/upload.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:get/get.dart';

void showAssetsDetailsPopup(AssetEntity assetEntityModel, UploadingData uploadingData) {
  showCupertinoDialog(
    context: Get.context!,
    barrierDismissible: true,
    builder: (context) {
      final ptSans2 = ptSansFont(14.2);
      // ignore: deprecated_member_use
      final title = (String t) => Text(t, style: ptSans2.copyWith(color: Get.theme.accentColor.withOpacity(.7)));
      final detail = (String t) => Text(t, style: ptSansFont().copyWith(fontWeight: FontWeight.w500));
      var sizedBoxH2 = sizedBoxH(25);
      return AlertDialog(
        title: Text('Details', style: ptSans2.copyWith(fontWeight: FontWeight.bold)),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            title('Name'),
            detail(assetEntityModel.title!),
            sizedBoxH2,
            sizedBoxH2,
            title('Location'),
            detail(assetEntityModel.relativePath!),
            if (assetEntityModel.type == AssetType.video) ...[
              sizedBoxH2,
              title('Video Duration'),
              detail((assetEntityModel.duration / 60).toStringAsFixed(2) + ' Minutes'),
            ],
            sizedBoxH2,
            title('Size'),
            FutureBuilder<int?>(
              future: () async {
                final f = await assetEntityModel.file;
                return await f!.length();
              }(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return detail('');
                }
                return detail((snapshot.data! / 1000000).toStringAsFixed(2) + ' MB');
              },
            ),
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

Future<String?> showTitleTextField(BuildContext context, UploadingData uploadingData) async {
  return showCupertinoDialog<String>(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      String? _value = uploadingData.title;
      final ptSans2 = ptSansFont();
      return AlertDialog(
        content: FormBuilderTextField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          name: uploadingData.id,
          buildCounter: _wordCounter,
          onChanged: (v) => _value = v,
          initialValue: uploadingData.title,
          style: ptSans2,
          maxLines: 2,
          maxLength: 350,
          decoration: _decoration('Title'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: ptSansFont().copyWith(color: themeColor)),
          ),
          TextButton(
            onPressed: () => Navigator.pop<String>(context, _value),
            child: Text('Ok', style: ptSansFont().copyWith(color: themeColor)),
          ),
        ],
      );
    },
  );
}

Widget _wordCounter(context, {currentLength, isFocused, maxLength}) {
  return Text(
    '$currentLength/$maxLength',
    semanticsLabel: 'character count',
    style: ptSansFont(),
  );
}

InputDecoration _decoration([String? label]) {
  const radius = BorderRadius.all(Radius.circular(5.0));
  // TextStyle _style = ptSans(39).copyWith(letterSpacing: 0.3);
  return InputDecoration(
    hintText: label,
    hintStyle: ptSansFont(),
    // hintStyle: ptSansFont(),
    errorStyle: ptSansFont(),
    // isCollapsed: true,
    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10.0),
    fillColor: Colors.black,
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black12, width: 2),
      borderRadius: radius,
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black12, width: 2),
      borderRadius: radius,
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: themeColor, width: 2.0),
      borderRadius: radius,
    ),
  );
}

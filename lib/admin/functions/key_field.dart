import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:meme_baaz/admin/main/view.dart';
import 'package:meme_baaz/constant/style.dart';
import 'package:meme_baaz/constant/theme.dart';
import 'package:meme_baaz/functions/getSnack_bar.dart';
import 'package:meme_baaz/functions/get_navigation.dart';

Future<void> showKeyField(BuildContext context) async {
  return showCupertinoDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      final ptSans2 = ptSansFont();
      var _value = '';

      return AlertDialog(
        content: FormBuilderTextField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          name: 'key_field',
          onChanged: (v) => _value = v!,
          initialValue: '',
          style: ptSans2,
          decoration: _decoration('Key'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: ptSansFont().copyWith(color: themeColor)),
          ),
          TextButton(
            onPressed: () async {
              try {
                final res = await FirebaseFirestore.instance.collection('config').doc('keys').get();
                final _data = res.data()?['key'] as String;
                if (_value == _data) {
                  Navigator.pop(context);
                  getNavigation(const AdminPage());
                } else {
                  await showToast(msg: 'incorrect key.');
                }
              } on FirebaseException catch (e) {
                await showToast(msg: e.message!);
              }
            },
            child: Text('Next', style: ptSansFont().copyWith(color: themeColor)),
          ),
        ],
      );
    },
  );
}

InputDecoration _decoration([String? label]) {
  const radius = BorderRadius.all(Radius.circular(5.0));
  // TextStyle _style = ptSans(39).copyWith(letterSpacing: 0.3);
  return InputDecoration(
    hintText: label,
    hintStyle: ptSansFont(),
    errorStyle: ptSansFont(),
    // isCollapsed: true,
    contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10.0),
    fillColor: Colors.black,
    border: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black12, width: 2),
      borderRadius: radius,
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black12, width: 2),
      borderRadius: radius,
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: themeColor, width: 2.0),
      borderRadius: radius,
    ),
  );
}

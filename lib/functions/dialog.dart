import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meme_baaz/constant/style.dart';
// import 'package:flutter/services.dart' show SystemNavigator;

Future<bool?> myDialog({
  required BuildContext context,
  String title = 'title',
  String content = 'Content',
  String yes = 'Yes',
  String no = 'No',
  void Function()? onTap,
  void Function()? noTap,
}) async {
  final style = ptSansFont();
  return showCupertinoDialog<bool>(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      final borderRadius = BorderRadius.circular(3);
      final borderRadius2 = BorderRadius.circular(10);
      final black26 = Colors.black26;
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: borderRadius2),
        title: Text(title.toUpperCase(), style: style),
        content: Text(content, style: style),
        actions: <Widget>[
          InkWell(
            borderRadius: borderRadius,
            splashColor: black26,
            onTap: noTap ?? () => Navigator.of(context).pop(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
              child: Text(no.toUpperCase(), style: style),
            ),
          ),
          // SizedBox(height: 16),
          InkWell(
            splashColor: black26,
            borderRadius: borderRadius,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
              child: Text(yes.toUpperCase(), style: style),
            ),
          ),
        ],
      );
    },
  );
}

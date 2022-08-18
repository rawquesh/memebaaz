import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter/services.dart' show SystemNavigator;
import 'package:meme_baaz/functions/dialog.dart';


Future<bool?> onBackPressed(BuildContext context) {
  return myDialog(
    context: context,
    title: 'Are you sure?',
    no: 'NO ',
    content: 'Do you want to exit an App',
    yes: 'YES',
    onTap: () => SystemNavigator.pop(),
  );
}

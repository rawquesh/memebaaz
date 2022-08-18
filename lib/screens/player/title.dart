import 'package:flutter/material.dart';
import 'package:meme_baaz/constant/style.dart';
import 'package:meme_baaz/constant/theme.dart';
import 'package:meme_baaz/models/content.dart';
import 'package:readmore/readmore.dart';

Padding contentTitleWidget(ContentModel content) {
  final tags = content.tags!.map((e) => '#' + e + ' ').join();

  return Padding(
    padding: EdgeInsets.symmetric(vertical: myFontSize(7), horizontal: myFontSize(10)),
    child: ReadMoreText(
      content.title!.isEmpty ? tags : '${content.title!} \n$tags',
      trimLines: 2,
      trimMode: TrimMode.Line,
      style: ptSansFont(15.5),
      lessStyle: ptSansFont(15.0).copyWith(color: themeColor),
      moreStyle: ptSansFont(15.0).copyWith(color: themeColor),
      // colo
    ),
  );
}

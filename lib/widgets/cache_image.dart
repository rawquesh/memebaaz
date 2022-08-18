// import 'package:meme_baaz/constant/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meme_baaz/constant/style.dart';
import 'package:octo_image/octo_image.dart';

Widget cacheImage(String url, {double? width, double? height, BoxFit boxFit = BoxFit.contain}) {
  return CachedNetworkImage(
    fit: boxFit,
    placeholder: (BuildContext context, String url) {
      return OctoPlaceholder.blurHash(hashString)(context);
    },
    imageUrl: url,
    fadeOutCurve: Curves.decelerate,
    fadeInCurve: Curves.decelerate,
    errorWidget: (context, url, error) => Container(
      height: height,
      width: width,
      color: Colors.white70,
      padding: const EdgeInsets.all(12),
      child: const Icon(Icons.error_rounded),
    ),
  );
}

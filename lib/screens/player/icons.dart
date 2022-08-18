// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:like_button/like_button.dart';
import 'package:line_icons/line_icons.dart';
import 'package:meme_baaz/ads/interstitial.dart';
import 'package:meme_baaz/constant/keys.dart';
import 'package:meme_baaz/constant/style.dart';
import 'package:meme_baaz/database/database.dart';
import 'package:meme_baaz/models/content.dart';
import 'package:meme_baaz/utils/download.dart';
import 'package:meme_baaz/utils/share.dart';

class ContentIcons extends StatefulWidget {
  final ContentModel contentModel;

  const ContentIcons({
    required this.contentModel,
    Key? key,
  }) : super(key: key);

  @override
  _ContentIconsState createState() => _ContentIconsState();
}

class _ContentIconsState extends State<ContentIcons> {
  final box = GetStorage();

  ContentModel get content => widget.contentModel;

  // int likes = 0;

  bool isLike = false;
  bool isSave = false;

  @override
  void initState() {
    boxinit();
    boxListeners();

    super.initState();
  }

  void boxListeners() {
    box.listenKey(StorageKeys.like, (value) {
      if (value is List) {
        if (value.contains(content.id)) {
          isLike = true;
        } else {
          isLike = false;
        }
        if (mounted) setState(() {});
        // print(likes);
      }
    });
    box.listenKey(StorageKeys.save, (value) {
      if (value is List) {
        if (value.contains(content.id)) {
          isSave = true;
        } else {
          isSave = false;
        }
        if (mounted) setState(() {});
        // print(likes);
      }
    });
  }

  void boxinit() {
    final value = box.read<List>(StorageKeys.like);
    if (value is List) {
      if (value.contains(content.id)) {
        isLike = true;
      } else {
        isLike = false;
      }
      if (mounted) setState(() {});
    }
    final save = box.read<List>(StorageKeys.save);
    if (save is List) {
      if (save.contains(content.id)) {
        isSave = true;
      } else {
        isSave = false;
      }
      if (mounted) setState(() {});
    }
  }

  Future<bool> like(_) {
    final likes = box.read<List>(StorageKeys.like);
    if (likes is List) {
      Timer(10.seconds, () => showInterstitialAds(5));
      if (isLike) {
        likes.remove(content.id);
        box.write(StorageKeys.like, likes);
        Database.addLike(content.id!, false);
        return Future.value(false);
      } else {
        likes.add(content.id);
        box.write(StorageKeys.like, likes);
        Database.addLike(content.id!, true);
        return Future.value(true);
      }
    }
    return Future.value(false);
  }

  Future<bool> save(_) async {
    final saves = box.read<List>(StorageKeys.save);
    if (saves is List) {
      if (isSave) {
        saves.remove(content.id);
        await box.write(StorageKeys.save, saves);
      } else {
        // ignore: unawaited_futures
        showInterstitialAds();
        saves.add(content.id);
        await box.write(StorageKeys.save, saves);
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        sizedBoxW(18),
        LikeButton(
          isLiked: isLike,
          onTap: like,
          size: myFontSize(30),
          circleColor: CircleColor(start: Get.theme.accentColor, end: Get.theme.accentColor),
          bubblesColor: BubblesColor(
            dotPrimaryColor: Get.theme.colorScheme.secondary,
            dotSecondaryColor: Get.theme.accentColor,
          ),
          likeBuilder: (bool isLiked) {
            return Icon(
              isLike ? LineIcons.heartAlt : LineIcons.heart,
            );
          },
          likeCount: content.likes,
        ),
        sizedBoxW(8),
        IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            // ignore: unawaited_futures
            showInterstitialAds();
            shareMedia(content);
          },
          icon: const Icon(LineIcons.share),
        ),
        const Spacer(),
        IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            showInterstitialAds();
            downloadMedia(content);
          },
          icon: const Icon(LineIcons.download),
        ),
        sizedBoxW(8),
        LikeButton(
          isLiked: isSave,
          onTap: save,
          size: myFontSize(30),
          circleColor: CircleColor(start: Get.theme.accentColor, end: Get.theme.accentColor),
          bubblesColor: BubblesColor(
            dotPrimaryColor: Get.theme.accentColor,
            dotSecondaryColor: Get.theme.accentColor,
          ),
          likeBuilder: (_) => Icon(isSave ? Icons.bookmark : LineIcons.bookmark),
        ),
        sizedBoxW(10),
      ],
    );
  }
}

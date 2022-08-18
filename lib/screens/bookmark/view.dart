import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:meme_baaz/constant/style.dart';
import 'package:meme_baaz/constant/theme.dart';
import 'package:meme_baaz/screens/player/icons.dart';
import 'package:meme_baaz/screens/player/shimmers.dart';
import 'package:meme_baaz/screens/player/media.dart';
import 'package:meme_baaz/screens/player/title.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'controller.dart';

class Bookmarks extends StatelessWidget {
  const Bookmarks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.put<BookmarkController>(BookmarkController());
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Saved', style: ptSansFont(18).copyWith(letterSpacing: 1)),
        ),
        body: RefreshIndicator(
          onRefresh: controller.fetchAllContent,
          color: themeColor,
          child: ListView(
            cacheExtent: 2000,
            children: [
              sizedBoxH(10),
              if (controller.isLoading.isTrue)
                const ContentShimmer()
              else if (controller.content.isEmpty)
                SizedBox(
                  height: screenHeight / 1.5,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/404.svg', height: myFontSize(50), color: themeColor),
                        const SizedBox(height: 15),
                        Text('No memes were found.', style: ptSansFont()),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                )
              else
                for (final content in controller.content)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(myFontSize(13)),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                'assets/new.jpg',
                                height: myFontSize(30),
                                width: myFontSize(30),
                              ),
                            ),
                            sizedBoxW(10),
                            Text('MemeBaaz', style: ptSansFont(13).copyWith(letterSpacing: 1, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(timeago.format(content.dateUploaded!).capitalizeFirst!, style: ptSansFont(11.5)),
                          ],
                        ),
                      ),
                      ContentMedia(content: content, key: Key(content.id!)),
                      contentTitleWidget(content),
                      ContentIcons(contentModel: content),
                    ],
                  ),
              sizedBoxH(100),
            ],
          ),
        ),
      );
    });
  }
}

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:meme_baaz/ads/banner.dart';
import 'package:meme_baaz/constant/style.dart';
import 'package:meme_baaz/constant/theme.dart';
import 'package:meme_baaz/screens/player/icons.dart';

import 'package:meme_baaz/screens/player/shimmers.dart';
import 'package:meme_baaz/screens/nav_bar/controller.dart';
import 'package:meme_baaz/screens/player/media.dart';
import 'package:meme_baaz/screens/player/title.dart';
import 'package:meme_baaz/utils/scroll_to_top.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final controller = Get.put<HomeController>(HomeController());
        final nController = Get.find<MyNavBarController>();
        return Scaffold(
          floatingActionButton: () {
            final _size = myFontSize(50);
            return SizedBox(
              height: _size,
              width: _size,
              child: PageTransitionSwitcher(
                duration: const Duration(milliseconds: 600),
                transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
                  return FadeThroughTransition(
                    fillColor: Colors.transparent,
                    animation: primaryAnimation,
                    secondaryAnimation: secondaryAnimation,
                    child: child,
                  );
                },
                child: nController.showFab.value
                    ? FloatingActionButton(
                        onPressed: () => scrollToTop(nController.scrollController.value),
                        child: Icon(Icons.arrow_upward, size: myFontSize(25)),
                      )
                    : const SizedBox.shrink(),
              ),
            );
          }(),
          body: LazyLoadScrollView(
            onEndOfPage: controller.fetchAllContentLazy,
            isLoading: controller.loading.isTrue,
            child: RefreshIndicator(
              onRefresh: controller.onRefresh,
              color: themeColor,
              edgeOffset: 80,
              child: CustomScrollView(
                cacheExtent: screenHeight * 2.6,
                controller: nController.scrollController.value,
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    elevation: 0,
                    title: Text('MemeBaaz', style: ptSansFont(18).copyWith(letterSpacing: 1)),
                    bottom: PreferredSize(
                      preferredSize: Size(screenWidth, 40),
                      child: SizedBox(
                        height: 40,
                        child: () {
                          if (controller.categories.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: myFontSize(10)),
                              child: const TagsShimmer(),
                            );
                          }
                          return ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (final cate in controller.categories)
                                Obx(
                                  () => Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 3),
                                    child: RawChip(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: .1),
                                      selectedColor: themeColor,
                                      backgroundColor: Get.isDarkMode ? Colors.white10 : Colors.black12,
                                      selected: cate == controller.selectedCategory.value,
                                      showCheckmark: false,
                                      onSelected: (b) {
                                        if (b) controller.onCategoriesSelect(cate);
                                      },
                                      label: Text(
                                        cate.capitalize ?? '',
                                        style: ptSansFont(13.5).copyWith(
                                          color: cate == controller.selectedCategory.value ? Colors.white : Get.theme.colorScheme.secondary,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        }(),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        sizedBoxH(10),
                        if (controller.loading.isTrue)
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
                                if (content.random == 0) BannerAdsView(),
                              ],
                            ),
                        if (controller.content.isNotEmpty)
                          Container(
                            alignment: Alignment.center,
                            height: myFontSize(30) + 20,
                            child: controller.ended.value
                                ? const Text('No More Memes.')
                                : SizedBox(
                                    height: myFontSize(20),
                                    width: myFontSize(20),
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation(Colors.black),
                                    ),
                                  ),
                          )
                      ],
                      addAutomaticKeepAlives: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

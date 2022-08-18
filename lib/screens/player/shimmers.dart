import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_baaz/constant/style.dart';
import 'package:shimmer/shimmer.dart';

class TagsShimmer extends StatelessWidget {
  const TagsShimmer({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Get.isDarkMode ? Colors.black45 : Colors.grey[300]!,
      highlightColor: Get.isDarkMode ? Colors.black12 : Colors.grey[100]!,
      child: Row(
        children: List.generate(
          4,
          (index) => Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ContentShimmer extends StatelessWidget {
  const ContentShimmer({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Get.isDarkMode ? Colors.black45 : Colors.grey[300]!,
      highlightColor: Get.isDarkMode ? Colors.black12 : Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: List.generate(
            2,
            (index) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: myFontSize(13)),
                  child: Row(
                    children: List.generate(
                      3,
                      (index) => Expanded(
                        child: Container(
                          height: 35,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          // width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                sizedBoxH(10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: myFontSize(13)),
                  child: Container(
                    height: screenHeight / 2,
                    width: 100,
                    margin: const EdgeInsets.symmetric(horizontal: 4),

                    // margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                sizedBoxH(30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meme_baaz/constant/style.dart';
import 'package:meme_baaz/constant/theme.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart' show GetPlatform;

class MyShimmer extends StatelessWidget {
  final bool showCart;

  const MyShimmer({Key? key, this.showCart = true}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: () {
          if (GetPlatform.isWeb) {
            return const SizedBox.expand(
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: themeColor,
                ),
              ),
            );
          }
        return  Column(
            children: [
              const LinearProgressIndicator(
                backgroundColor: themeColor,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xffFFA3D9)),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(6.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          height: 30,
                        ),
                        const SizedBox(height: 5),
                        ...List.generate(
                          3,
                          (_) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        _newMethod(context),
                                        const SizedBox(width: 10),
                                        _newMethod(context),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(height: 5),
                        // Container(color: Colors.white, height: 35),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }());
  }

  Widget _newMethod(BuildContext context) {
    Widget container() => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
          ),
          height: 10,
        );

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: container(),
            ),
            // SizedBox(height: 4),
            // container(),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: screenWidth / 4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
                height: 10,
              ),
            ),
            const SizedBox(height: 4),
            container(),
          ],
        ),
      ),
    );
  }
}

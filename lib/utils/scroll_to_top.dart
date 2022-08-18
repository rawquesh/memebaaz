import 'package:flutter/cupertino.dart';

Future<void> scrollToTop(ScrollController scrollController) async {
  scrollController.jumpTo(
    scrollController.position.minScrollExtent + 350,
  );
  await scrollController.animateTo(
    scrollController.position.minScrollExtent,
    duration: const Duration(milliseconds: 300),
    curve: Curves.fastOutSlowIn,
  );
}

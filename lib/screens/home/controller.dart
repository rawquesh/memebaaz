import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:meme_baaz/ads/interstitial.dart';
import 'package:meme_baaz/functions/getSnack_bar.dart';
import 'package:meme_baaz/models/content.dart';
import 'package:meme_baaz/screens/nav_bar/controller.dart';

class HomeController extends GetxController {
  RxList<String> categories = <String>[].obs;
  RxList<ContentModel> content = <ContentModel>[].obs;

  RxString selectedCategory = 'recent'.obs;
  RxBool ended = false.obs;
  RxBool loading = false.obs;

  DocumentSnapshot? _lastDocumentSnapshot;

  static const int _limit = 15;

  Future<void> onRefresh() async {
    _lastDocumentSnapshot = null;
    ended.value = false;
    await fetchAllContent();
  }

  Query get _query => FirebaseFirestore.instance
      .collection('content')
      .orderBy('date_uploaded', descending: true)
      .where('status', isEqualTo: ContentStatus.verified)
      .limit(_limit);

  Future<void> fetchAllContent() async {
    loading.value = true;
    content.clear();
    late QuerySnapshot res;
    final _content = <ContentModel>[];
    try {
      if ('recent' == selectedCategory.value) {
        res = await _query.get();
      } else if ('popular' == selectedCategory.value) {
        Query query = FirebaseFirestore.instance
            .collection('content')
            .orderBy('likes', descending: true)
            .where('status', isEqualTo: ContentStatus.verified)
            .limit(_limit);
        res = await query.get();
      } else {
        res = await _query.where('tags', arrayContains: selectedCategory.value).get();
      }
      loading.value = true;
    } on FirebaseException catch (e) {
      await showToast(msg: e.message!);
    }

    loading.value = false;
    res.docs.forEach((doc) => _content.add(ContentModel.fromSnapshot(doc)));
    content.addAll(_content);
    if (_content.length < _limit) {
      ended.value = true;
    } else {
      _lastDocumentSnapshot = res.docs.last;
    }
    return;
  }

  Future<void> fetchAllContentLazy() async {
    Timer(3.seconds, () => showInterstitialAds(1));
    if (ended.value) return;
    late QuerySnapshot res;
    final _content = <ContentModel>[];
    try {
      if (selectedCategory.value == 'recent') {
        res = await _query.startAfterDocument(_lastDocumentSnapshot!).get();
      } else if ('popular' == selectedCategory.value) {
        Query query = FirebaseFirestore.instance
            .collection('content')
            .orderBy('likes', descending: true)
            .where('status', isEqualTo: ContentStatus.verified)
            .startAfterDocument(_lastDocumentSnapshot!)
            .limit(_limit);
        res = await query.get();
      } else {
        res = await _query.where('tags', arrayContains: selectedCategory.value).startAfterDocument(_lastDocumentSnapshot!).get();
      }
    } on FirebaseException catch (e) {
      print(e.message);
    }
    res.docs.forEach((doc) => _content.add(ContentModel.fromSnapshot(doc)));
    content.addAll(_content);
    if (_content.length < _limit) {
      ended.value = true;
    } else {
      _lastDocumentSnapshot = res.docs.last;
    }
  }

  Future<void> fetchCategories() async {
    try {
      final res = await FirebaseFirestore.instance.collection('config').doc('categories').get();
      final _data = (res.data()?['data']).cast<String>();
      _data.insertAll(0, ['recent', 'popular']);
      categories.assignAll(_data);
    } on FirebaseException catch (e) {
      await showToast(msg: e.message!);
    }
  }

  void onCategoriesSelect(String v) {
    if (loading.isTrue) return;
    selectedCategory.value = v;
    showInterstitialAds(5);
    _lastDocumentSnapshot = null;
    ended.value = false;
    fetchAllContent();
    var cntrl = Get.find<MyNavBarController>().scrollController.value;
    cntrl.jumpTo(cntrl.position.minScrollExtent);
  }

  @override
  void onInit() {
    fetchCategories();
    fetchAllContent();
    super.onInit();
  }
}

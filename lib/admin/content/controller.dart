import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_baaz/models/content.dart';

class ContentPageAdminController extends GetxController {
  RxList<String> categories = <String>['verified', 'pending', 'hold'].obs;
  RxList<ContentModel> content = <ContentModel>[].obs;

  RxString selectedCategory = 'verified'.obs;

  final Rx<ScrollController> scrollController = ScrollController().obs;

  RxBool showFab = false.obs;

  RxBool ended = false.obs;
  RxBool loading = false.obs;

  DocumentSnapshot? _lastDocumentSnapshot;

  static const int _limit = 15;

  Query get _query => FirebaseFirestore.instance.collection('content').orderBy('date_uploaded', descending: true).limit(_limit);

  Future<void> fetchAllContent() async {
    loading.value = true;
    content.clear();
    late QuerySnapshot res;
    final _content = <ContentModel>[];
    try {
      res = await _query.where('status', isEqualTo: selectedCategory.value).get();

      loading.value = true;
    } on FirebaseException catch (e) {
      print(e.message);
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

  void fetchAllServicesLazy() async {
    if (ended.value) return;
    late QuerySnapshot res;
    final _content = <ContentModel>[];
    try {
      res = await _query.where('status', isEqualTo: selectedCategory.value).startAfterDocument(_lastDocumentSnapshot!).get();
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

  Future<void> onRefresh() async {
    _lastDocumentSnapshot = null;
    ended.value = false;
    await fetchAllContent();
  }

  void changeStatus(String uid, String status) {
    content.removeWhere((e) => e.id == uid);
    FirebaseFirestore.instance.collection('content').doc(uid).update({
      'status': status,
      'date_uploaded': DateTime.now(),
    });
  }

  void deleteDocForver(String uid) {
    content.removeWhere((e) => e.id == uid);
    FirebaseFirestore.instance.collection('content').doc(uid).delete();
  }

  void onCategoriesSelect(String v) {
    if (loading.isTrue) return;
    selectedCategory.value = v;
    _lastDocumentSnapshot = null;
    ended.value = false;
    fetchAllContent();
    final cntrl = scrollController.value;
    cntrl.jumpTo(cntrl.position.minScrollExtent);
  }

  @override
  void onInit() {
    fetchAllContent();
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels > 350) {
        showFab.value = true;
      } else {
        showFab.value = false;
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.value.dispose();
    super.onClose();
  }
}

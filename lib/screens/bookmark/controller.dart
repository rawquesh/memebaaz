import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meme_baaz/constant/keys.dart';
import 'package:meme_baaz/models/content.dart';

class BookmarkController extends GetxController {
  RxList<ContentModel> content = <ContentModel>[].obs;
  RxBool isLoading = false.obs;

  Future<void> fetchAllContent() async {
    final box = GetStorage();
    final saveIds = box.read<List>(StorageKeys.save);
    isLoading.value = true;
    content.clear();
    try {
      final res = await FirebaseFirestore.instance
          .collection('content')
          .where(FieldPath.documentId, whereIn: saveIds)
          // .orderBy('date_uploaded', descending: true)
          .where('status', isEqualTo: ContentStatus.verified)
          .get();
      res.docs.forEach((doc) => content.add(ContentModel.fromSnapshot(doc)));
    } on FirebaseException catch (e) {
      print(e.message);
    }
    isLoading.value = false;
    return;
  }

  @override
  void onInit() {
    fetchAllContent();
    super.onInit();
  }
}

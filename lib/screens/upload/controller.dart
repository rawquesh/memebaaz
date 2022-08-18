import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:meme_baaz/constant/theme.dart';
import 'package:meme_baaz/models/content.dart';
import 'package:meme_baaz/utils/compression.dart';
import 'package:meme_baaz/models/upload.dart';
import 'package:meme_baaz/utils/getAspectRatio.dart';
import 'package:meme_baaz/utils/sizeCheck.dart';
import 'package:meme_baaz/widgets/assetsdetailspopup.dart';
import 'package:meme_baaz/functions/getSnack_bar.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class UploadController extends GetxController {
  RxList<String> categories = <String>[].obs;
  RxList<AssetEntity> selectedAssets = <AssetEntity>[].obs;
  RxList<UploadingData> uploadingData = <UploadingData>[].obs;
  final firestoreInstance = FirebaseFirestore.instance;

  Future<void> fetchCategories() async {
    try {
      final res = await firestoreInstance.collection('config').doc('categories').get();
      final _data = ((res.data()?['data']).cast<String>());
      categories.assignAll(_data);
    } on FirebaseException catch (e) {
      await showToast(msg: e.message!);
    }
  }

  Future<void> loadAssets() async {
    try {
      final resultList = await AssetPicker.pickAssets(
        Get.context!,
        pickerConfig: AssetPickerConfig(
        maxAssets: 10,

        filterOptions: FilterOptionGroup(
          imageOption: const FilterOption(
            needTitle: true,
            sizeConstraint: SizeConstraint(maxHeight: 3000, maxWidth: 3000, minHeight: 50, minWidth: 50),
          ),
          videoOption: FilterOption(
            durationConstraint: DurationConstraint(max: 3.minutes),
            needTitle: true,
          ),
        ),
        requestType: RequestType.common,
        selectedAssets: selectedAssets,
        textDelegate: EnglishAssetPickerTextDelegate(),
        themeColor: themeColor,
        ),
      );

      if (resultList == null) {
        return;
      }

      resultList.removeWhere((e) => selectedAssets.map((e) => e.id).contains(e.id));

      var totalRemoved = 0;
      for (final item in List.from(resultList)) {
        final s = await sizeCheck(item);
        if (!s) {
          resultList.remove(item);
          totalRemoved++;
        }
      }
      if (totalRemoved != 0) await showToast(msg: '$totalRemoved assets has over size, removed.', short: false);

      selectedAssets.addAll(resultList);
      uploadingData.addAll(resultList.map((e) => UploadingData(id: e.id, tags: [if (e.type == AssetType.image) 'images' else 'videos'])));
      uploadAssets(resultList);
    } on Exception catch (e) {
      await showToast(msg: e.toString());
    }
  }

  void uploadAssets(List<AssetEntity>? assetEntities) {
    for (final asset in assetEntities!) {
      final path = 'content/${Random().nextInt(100000)}-${asset.title!.removeAllWhitespace}';

      if (asset.type == AssetType.video) {
        asset.file.then((videoData) {
          if (uploadingData.where((e) => e.id == asset.id).isNotEmpty) {
            final model = uploadingData.singleWhere((e) => e.id == asset.id);
            final i = uploadingData.indexOf(model);
            uploadingData[i] = model.copyWith(uploadingStatus: UploadingStatus.uploading);
          }
          FirebaseStorage.instance.ref().child(path).putFile(videoData!).then((_task) {
            if (uploadingData.where((e) => e.id == asset.id).isNotEmpty) {
              final model = uploadingData.singleWhere((e) => e.id == asset.id);
              final i = uploadingData.indexOf(model);
              final downUrl = 'https://storage.googleapis.com/${_task.ref.bucket}/${_task.ref.fullPath}';
              uploadingData[i] = model.copyWith(url: downUrl, uploadingStatus: UploadingStatus.ready);
            }
          });
        });

        // final videoData = await videoCompress(await asset.file);
      } else if (asset.type == AssetType.image) {
        asset.file.then((_file) {
          imageCompress(_file).then((imageData) {
            if (uploadingData.where((e) => e.id == asset.id).isNotEmpty) {
              final model = uploadingData.singleWhere((e) => e.id == asset.id);
              final i = uploadingData.indexOf(model);
              uploadingData[i] = model.copyWith(uploadingStatus: UploadingStatus.uploading);
            }
            FirebaseStorage.instance.ref().child(path).putData(imageData).then((_task) {
              if (uploadingData.where((e) => e.id == asset.id).isNotEmpty) {
                final model = uploadingData.singleWhere((e) => e.id == asset.id);
                final i = uploadingData.indexOf(model);
                final downUrl = 'https://storage.googleapis.com/${_task.ref.bucket}/${_task.ref.fullPath}';
                uploadingData[i] = model.copyWith(url: downUrl, uploadingStatus: UploadingStatus.ready);
                // print(downUrl);
              }
            });
          });
        });
      }
    }
  }

  void deleteAsset(AssetEntity assetEntity) {
    selectedAssets.removeWhere((e) => e.id == assetEntity.id);
    uploadingData.removeWhere((e) => e.id == assetEntity.id);
  }

  Future<void> upload() async {
    final _pendings = uploadingData.where((b) => b.uploadingStatus != UploadingStatus.ready).length;
    if (_pendings != 0) {
      await showToast(msg: 'All the assets must ready.');
      return;
    }
    final _urlCheck = uploadingData.where((b) => b.url == null).length;
    if (_urlCheck != 0) {
      await showToast(msg: 'url issue, contact developer.');
      return;
    }
    final _tagsCheck = uploadingData.where((b) => b.tags.isEmpty).length;
    if (_tagsCheck != 0) {
      await showToast(msg: 'All the assets must have atleast one tag.');
      return;
    }

    if (uploadingData.length != selectedAssets.length) {
      await showToast(msg: 'something mismatch, contact developer.');
    }

    var totalUploaded = 0;
    await showToast(msg: 'Uploading.');

    for (var i = 0; i < selectedAssets.length; i++) {
      final asset = selectedAssets[i];
      final assetData = uploadingData.singleWhere((e) => asset.id == e.id);

      final content = ContentModel(
        dateUploaded: DateTime.now(),
        likes: 0,
        size: await getAssetSize(asset),
        status: ContentStatus.pending,
        url: assetData.url,
        type: asset.type == AssetType.image ? 'image' : 'video',
        title: assetData.title,
        tags: assetData.tags,
        aspectRatio: getAspectRatio(asset),
      );
      try {
        await firestoreInstance.collection('content').add(content.toJson());
        totalUploaded++;
      } on FirebaseException catch (e) {
        await showToast(msg: e.message!);
      }
    }
    selectedAssets.clear();
    uploadingData.clear();
    if (totalUploaded != 0) await showToast(msg: '$totalUploaded assets uploaded.');
  }

  Future<void> titleTextField(AssetEntity asset) async {
    final i = uploadingData.indexWhere((e) => e.id == asset.id);
    final model = uploadingData[i];
    final r = await showTitleTextField(Get.context!, model);
    if (r == null) return;
    uploadingData[i] = model.copyWith(title: r);
  }

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }
}

// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meme_baaz/constant/style.dart';
import 'package:get/get.dart';
import 'package:meme_baaz/constant/theme.dart';
import 'package:meme_baaz/functions/getSnack_bar.dart';
import 'package:meme_baaz/screens/upload/video_player.dart';
import 'package:meme_baaz/models/upload.dart';
import 'package:meme_baaz/screens/upload/controller.dart';
import 'package:meme_baaz/widgets/assetsdetailspopup.dart';
import 'package:meme_baaz/widgets/decoration.dart';
import 'package:meme_baaz/widgets/gradient_button.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'privacy_policy.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<UploadController>(UploadController());
    return GestureDetector(
      onTap: () => WidgetsBinding.instance.focusManager.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Upload Memes', style: ptSansFont()),
          elevation: 0,
          actions: [
            Obx(() {
              if (controller.selectedAssets.isEmpty) {
                return const SizedBox.shrink();
              }
              return IconButton(
                onPressed: null,
                icon: Text('${controller.selectedAssets.length}/15', style: ptSansFont()),
              );
            }),
          ],
        ),
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                for (int i = 0; i < controller.selectedAssets.length; i++)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.zero,
                    decoration: buildDecoration(radius: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        sizedBoxH(10),
                        Padding(
                          padding: EdgeInsets.all(myFontSize(5)),
                          child: Row(
                            children: [
                              Text('${i + 1}. ', style: ptSansFont(15.5).copyWith(fontWeight: FontWeight.bold)),
                              Text(controller.selectedAssets[i].title!, style: ptSansFont(14.5)),
                            ],
                          ),
                        ),
                        const Divider(height: 5),
                        sizedBoxH(10),
                        () {
                          final asset = controller.selectedAssets[i];
                          final loading = SizedBox(
                            height: screenHeight / 1.5,
                            width: screenWidth,
                            child: const Center(child: CupertinoActivityIndicator()),
                          );
                          if (asset.type == AssetType.image) {
                            return Image(image: AssetEntityImageProvider(asset));
                          } else if (asset.type == AssetType.video) {
                            return FutureBuilder<File?>(
                              future: asset.file,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData || snapshot.data?.path == null) {
                                  return loading;
                                }
                                return AssetVideoPlayer(assetEntity: asset, key: Key(asset.id));
                              },
                            );
                          }
                          return SizedBox(
                            height: 200,
                            width: screenWidth,
                            child: Center(child: Text('Something went wrong', style: ptSansFont(20))),
                          );
                        }(),
                        sizedBoxH(10),
                        textField(i),
                        buildButtons(i),
                        sizedBoxH(5),
                        buildAssetType(i),
                        sizedBoxH(5),
                      ],
                    ),
                  ),
                if (controller.selectedAssets.length < 15)
                  GestureDetector(
                    onTap: controller.loadAssets,
                    child: Container(
                      height: controller.selectedAssets.isEmpty ? screenHeight - 200 : 200,
                      width: screenWidth,
                      decoration: BoxDecoration(
                        border: Border.all(width: .5, color: Get.theme.accentColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.upload_file_outlined, size: myFontSize(35)),
                          sizedBoxH(30),
                          Text('Choose files to upload', textAlign: TextAlign.center, style: ptSansFont()),
                          sizedBoxH(10),
                          CupertinoButton(
                            onPressed: () => showUploadPrivacyPolicy(context),
                            child: Text('PRIVACY & POLICY', style: ptSansFont(12).copyWith(color: themeColor)),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (controller.selectedAssets.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CustomButton(
                      height: myFontSize(50),
                      width: screenWidth,
                      radius: 5,
                      text: 'Upload',
                      onTap: controller.upload,
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAssetType(int index) {
    return Obx(
      () {
        final controller = Get.find<UploadController>();
        if (controller.categories.isEmpty) {
          return const SizedBox.shrink();
        }
        final asset = controller.selectedAssets[index];
        final assetData = controller.uploadingData.singleWhere((e) => e.id == asset.id);
        final uploadingindex = controller.uploadingData.indexOf(assetData);
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Meme Tags -', style: ptSansFont()),
              Wrap(
                children: [
                  for (final cate in controller.categories.where((c) {
                    if (asset.type == AssetType.image && c == 'videos') {
                      return false;
                    } else if (asset.type == AssetType.video && c == 'images') {
                      return false;
                    }
                    return true;
                  }))
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: RawChip(
                        deleteIconColor: Colors.white,
                        onDeleted: assetData.tags.contains(cate)
                            ? () {
                                if (cate == 'videos' || cate == 'images') {
                                  showToast(msg: "asset type can't be removed.");
                                  return;
                                }
                                final _type = assetData.tags;
                                _type.remove(cate);
                                controller.uploadingData[uploadingindex] = assetData.copyWith(tags: _type);
                              }
                            : null,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: .1),
                        selectedColor: themeColor,
                        backgroundColor: Get.isDarkMode ? Colors.white10 : Colors.black12,
                        selected: assetData.tags.contains(cate),
                        showCheckmark: false,
                        onSelected: (b) {
                          if (b) {
                            final _type = List<String>.from(assetData.tags);
                            _type.add(cate);
                            controller.uploadingData[uploadingindex] = assetData.copyWith(tags: _type);
                          }
                        },
                        label: Text(
                          cate.capitalize!,
                          style: ptSansFont(14).copyWith(
                            color: assetData.tags.contains(cate) ? Colors.white : Get.theme.accentColor,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildButtons(int i) {
    return Obx(
      () {
        final controller = Get.find<UploadController>();
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              OutlinedButton(
                onPressed: () {
                  final asset = controller.selectedAssets[i];
                  final uploadingData = controller.uploadingData.singleWhere((e) => e.id == asset.id);
                  showAssetsDetailsPopup(asset, uploadingData);
                },
                child: Icon(
                  Icons.info,
                  color: Get.theme.accentColor,
                ),
              ),
              sizedBoxW(10),
              Expanded(
                flex: 70,
                child: OutlinedButton(
                  onPressed: null,
                  child: () {
                    final asset = controller.selectedAssets[i];
                    final uploadingData = controller.uploadingData.singleWhere((e) => e.id == asset.id);
                    if (uploadingData.uploadingStatus == UploadingStatus.ready) {
                      return Text(
                        getUploadingStatus(uploadingData.uploadingStatus),
                        overflow: TextOverflow.ellipsis,
                        style: ptSansFont(13.5).copyWith(color: Colors.green.shade600),
                      );
                    }
                    return Text(getUploadingStatus(uploadingData.uploadingStatus), overflow: TextOverflow.ellipsis, style: ptSansFont(13.5));
                  }(),
                ),
              ),
              sizedBoxW(10),
              Expanded(
                flex: 100,
                child: OutlinedButton(
                  onPressed: () => controller.deleteAsset(controller.selectedAssets[i]),
                  child: Text('Delete', style: ptSansFont().copyWith(color: Colors.red.shade600, fontWeight: FontWeight.w500)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  GestureDetector textField(int i) {
    final controller = Get.find<UploadController>();
    return GestureDetector(
      onTap: () => controller.titleTextField(controller.selectedAssets[i]),
      child: Obx(
        () {
          final asset = controller.selectedAssets[i];
          final title = controller.uploadingData.singleWhere((e) => e.id == asset.id).title;
          return Container(
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Get.theme.accentColor.withOpacity(.5)),
              borderRadius: BorderRadius.circular(5),
            ),
            child: title.isNotEmpty
                ? Text(title, style: ptSansFont())
                : Text(
                    'Title',
                    style: ptSansFont().copyWith(color: Get.theme.accentColor.withOpacity(.5)),
                  ),
          );
        },
      ),
    );
  }
}

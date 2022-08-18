// import 'dart:typed_data';

// import 'package:wechat_assets_picker/wechat_assets_picker.dart' show AssetEntity;

// class AssetEntityModel {
//   final AssetEntity? assetEntity;
//   final String? id;
//   final String title;
//   final String? url;
//   final UploadingStatus status;
//   // final Uint8List? imageData;
//   // final File? videoData;

//   AssetEntityModel({
//     this.assetEntity,
//     this.id,
//     this.title = "",
//     this.url,
//     this.status = UploadingStatus.loaded,
//     // this.imageData,
//     // this.videoData,
//   });

//   AssetEntityModel copyWith({
//     AssetEntity? assetEntity,
//     String? id,
//     String? title,
//     String? url,
//     UploadingStatus? status,
//     Uint8List? imageData,
//     // File? videoData,
//   }) {
//     return AssetEntityModel(
//       assetEntity: assetEntity ?? this.assetEntity,
//       id: id ?? this.id,
//       title: title ?? this.title,
//       url: url ?? this.url,
//       // imageData: imageData ?? this.imageData,
//       status: status ?? this.status,
//       // videoData: videoData ?? this.videoData,
//     );
//   }
// }

enum UploadingStatus { loaded, compressing, uploading, ready, error }

String getUploadingStatus(UploadingStatus uploadingStatus) {
  switch (uploadingStatus) {
    case UploadingStatus.loaded:
      return 'Loaded';
    case UploadingStatus.compressing:
      return 'Compressing';
    case UploadingStatus.uploading:
      return 'Uploading';
    case UploadingStatus.error:
      return 'Error';
    case UploadingStatus.ready:
      return 'Ready';
    default:
      return 'failed';
  }
}

class UploadingData {
  final String id;
  final String? url;
  final String title;
  final List<String> tags;
  final UploadingStatus uploadingStatus;

  UploadingData({required this.id, this.url, this.uploadingStatus = UploadingStatus.loaded, this.title = '', this.tags = const []});

  UploadingData copyWith({
    String? id,
    String? url,
    String? title,
    List<String>? tags,
    UploadingStatus? uploadingStatus,
  }) {
    return UploadingData(
      id: id ?? this.id,
      title: title ?? this.title,
      uploadingStatus: uploadingStatus ?? this.uploadingStatus,
      url: url ?? this.url,
      tags: tags ?? this.tags,
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

double getAspectRatio(AssetEntity assetEntity) {
  if (assetEntity.orientation == 270) {
    return Size(assetEntity.height.toDouble(), assetEntity.width.toDouble()).aspectRatio;
  }
  return assetEntity.size.aspectRatio;
}

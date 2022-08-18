import 'package:wechat_assets_picker/wechat_assets_picker.dart';

Future<bool> sizeCheck( assetEntity) async {
  final _file = await assetEntity.file;
  final _bytes = await _file!.length();
  final _size = _bytes / 1000000;

  if (assetEntity.type == AssetType.image) {
    if (_size < 5.0) {
      return true;
    } else {
      return false;
    }
  } else if (assetEntity.type == AssetType.video) {
    if (_size < 5.0) {
      return true;
    } else {
      return false;
    }
  }

  return false;
}

Future<double> getAssetSize(AssetEntity assetEntity) async {
  final _file = await assetEntity.file;
  final _bytes = await _file!.length();
  return double.parse((_bytes / 1000000).toStringAsFixed(2));
}

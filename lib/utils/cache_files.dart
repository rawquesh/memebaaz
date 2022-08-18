import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

Future<File?> fetchCacheVideo(String url) async {
  final cacheManager = DefaultCacheManager();
  FileInfo? fileInfo;
  fileInfo = await cacheManager.getFileFromCache(url);
  if (fileInfo?.file == null) {
    print(url);
    fileInfo = await cacheManager.downloadFile(url);
  }
  return fileInfo?.file;
}

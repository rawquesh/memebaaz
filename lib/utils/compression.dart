import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:video_compress/video_compress.dart';

Future<Uint8List> imageCompress(File? file) async {
  return await FlutterImageCompress.compressWithList(
    file!.readAsBytesSync(),
    minWidth: 700,
    minHeight: 700,
    quality: 93,
  );
}

// Future<File> videoCompress(File? file) async {
//   return file!;
//   MediaInfo? mediaInfo = await VideoCompress.compressVideo(file!.path, includeAudio: true,);
//   if (mediaInfo == null) {
//     return file;
//   }
//   return mediaInfo.file!;
// }

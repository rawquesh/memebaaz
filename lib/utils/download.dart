import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:meme_baaz/functions/getSnack_bar.dart';
import 'package:meme_baaz/models/content.dart';

import 'cache_files.dart';

Future<void> downloadMedia(ContentModel content) async {
  final _file = await fetchCacheVideo(content.url!);
  if (content.type == 'image') {
    await ImageGallerySaver.saveImage(await _file!.readAsBytes());
    await showToast(msg: 'Saved successfully');
  } else {
    await ImageGallerySaver.saveFile(_file!.path);
    await showToast(msg: 'Saved successfully');
  }
}

import 'package:meme_baaz/models/content.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

import 'cache_files.dart';

Future<void> shareMedia(ContentModel content) async {
  final type = content.url!.split('.').last;
  final _file = await fetchCacheVideo(content.url!);
  await WcFlutterShare.share(
    sharePopupTitle: 'share',
    subject: 'Meme from MemeBaaz app',
    text: 'Downlaod MemeBaaz app now : https://play.google.com/store/apps/details?id=com.memebaaz.MemeBaaz',
    fileName: 'memebaaz_video.$type',
    mimeType: '${content.type}/$type',
    bytesOfFile: await _file!.readAsBytes(),
  );
}

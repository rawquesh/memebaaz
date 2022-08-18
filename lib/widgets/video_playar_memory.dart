// import 'dart:io';

// import 'package:better_player/better_player.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:meme_baaz/constant/style.dart';
// import 'package:wechat_assets_picker/wechat_assets_picker.dart';

// class MyVideoPlayer extends StatefulWidget {
//   const MyVideoPlayer({
//     Key? key,
//     required this.asset,
//   }) : super(key: key);

//   final AssetEntity asset;

//   @override
//   _MyVideoPlayerState createState() => _MyVideoPlayerState();
// }

// class _MyVideoPlayerState extends State<MyVideoPlayer> {
//   File? _file;

//   AssetEntity get asset => widget.asset;

//   @override
//   void initState() {
//     loadFile();
//     super.initState();
//   }

//   Future<void> loadFile() async {
//     final f = await asset.file;
//     _file = f!;
//     setState(() {});
//   }



//   Widget get loading => SizedBox(
//         height: 200,
//         width: screenWidth,
//         child: Center(child: CupertinoActivityIndicator()),
//       );

//   @override
//   Widget build(BuildContext context) {
//     if (_file == null) {
//       return loading;
//     }
//     return AspectRatio(
//       aspectRatio: asset.size.aspectRatio,
//       child: BetterPlayer.file(
//         _file!.path,
//         betterPlayerConfiguration: BetterPlayerConfiguration(
//           aspectRatio: widget.asset.size.aspectRatio,
//           looping: true,
//           controlsConfiguration: BetterPlayerControlsConfiguration(
//             enableFullscreen: false,
//             enableOverflowMenu: false,
//             enablePip: false,
//             enableSkips: false,
//           ),
//         ),
//       ),
//     );
//   }
// }

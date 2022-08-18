import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:meme_baaz/constant/style.dart';
// import 'package:meme_baaz/constant/style.dart';
import 'package:octo_image/octo_image.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class AssetVideoPlayer extends StatefulWidget {
  const AssetVideoPlayer({
    required this.assetEntity,
    required Key key,
  }) : super(key: key);

  final AssetEntity assetEntity;

  @override
  _AssetVideoPlayerState createState() => _AssetVideoPlayerState();
}

class _AssetVideoPlayerState extends State<AssetVideoPlayer> {
  CachedVideoPlayerController? _controller;
  bool isPlayerInit = false;
  bool isPaused = false;

  @override
  void initState() {
    initVideoPlayer(widget.assetEntity);
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> initVideoPlayer(AssetEntity assetEntity) async {
    if (isPlayerInit == false) {
      isPlayerInit = true;
      final file = await assetEntity.file;
      _controller = CachedVideoPlayerController.file(file!);
      await _controller!.initialize();
      await _controller?.setLooping(true);
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget loading() {
      return SizedBox(
        height: screenHeight / 1.5,
        width: screenWidth,
        child: OctoPlaceholder.blurHash(hashString)(context),
      );
    }

    return VisibilityDetector(
      key: (widget.key)!,
      onVisibilityChanged: (VisibilityInfo info) {
        if (_controller != null) {
          if (_controller!.value.isInitialized) {
            if (info.visibleFraction > .90) {
              if (!isPaused) {
                _controller!.play();
              }
            } else {
              if (_controller!.value.isPlaying && mounted) {
                _controller!.pause();
              }
            }
          }
        }
      },
      child: GestureDetector(
        onTap: () {
          if (_controller!.value.isPlaying) {
            isPaused = true;
            _controller!.pause();
          } else {
            isPaused = false;
            _controller!.play();
          }
        },
        child: SizedBox(
          height: (screenHeight / 3.5) + 170,
          width: screenWidth,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: screenHeight / 1.8,
              minWidth: screenWidth,
              maxWidth: screenWidth,
              minHeight: 100,
            ),
            child: () {
              if (_controller != null) {
                if (_controller!.value.isInitialized) {
                  return FittedBox(
                    clipBehavior: Clip.hardEdge,
                    fit: BoxFit.cover,
                    child: SizedBox(
                      height: _controller!.value.size.height,
                      width: _controller!.value.size.width,
                      child: CachedVideoPlayer(_controller!),
                    ),
                  );
                } else {
                  return loading();
                }
              } else {
                return loading();
              }
            }(),
          ),
        ),
      ),
    );
  }
}

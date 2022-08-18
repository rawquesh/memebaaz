import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meme_baaz/ads/interstitial.dart';
import 'package:meme_baaz/constant/keys.dart';
import 'package:meme_baaz/constant/style.dart';
// import 'package:meme_baaz/constant/style.dart';
import 'package:meme_baaz/database/database.dart';
import 'package:meme_baaz/models/content.dart';
import 'package:meme_baaz/widgets/cache_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:octo_image/octo_image.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ContentMedia extends StatefulWidget {
  final ContentModel content;
  final bool like;

  const ContentMedia({
    required this.content,
    required Key key,
    this.like = true,
  }) : super(key: key);

  @override
  _ContentMediaState createState() => _ContentMediaState();
}

class _ContentMediaState extends State<ContentMedia> {
  bool isLike = false;
  final FlareControls flareControls = FlareControls();
  final box = GetStorage();
  CachedVideoPlayerController? _controller;
  bool isPlayerInit = false;
  bool isPaused = false;

  ContentModel get content => widget.content;

  @override
  void initState() {
    initVideoPlayer(content);
    boxinit();
    boxListeners();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> initVideoPlayer(ContentModel contentModel) async {
    print(contentModel.url!);
    if (isPlayerInit == false && contentModel.type == 'video') {
      isPlayerInit = true;
      _controller = CachedVideoPlayerController.network(contentModel.url!);
      await _controller!.initialize();
      await _controller?.setLooping(true);
      if (mounted) {
        setState(() {});
      }
    }
  }

  void boxListeners() {
    box.listenKey(StorageKeys.like, (value) {
      if (value is List) {
        if (value.contains(content.id)) {
          isLike = true;
        } else {
          isLike = false;
        }
      }
    });
  }

  void boxinit() {
    final value = box.read<List>(StorageKeys.like);
    if (value is List) {
      if (value.contains(content.id)) {
        isLike = true;
      } else {
        isLike = false;
      }
    }
  }

  void likeEffect() async {
    if (widget.like == false) return;
    flareControls.play('like');
    final likes = box.read<List>(StorageKeys.like);
    if (likes is List) {
      // ignore: unawaited_futures
      showInterstitialAds(20);
      if (!isLike) {
        likes.add(content.id);
        await box.write(StorageKeys.like, likes);
        await Database.addLike(content.id!, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget loading() {
      return SizedBox.expand(
        child: OctoPlaceholder.blurHash(hashString)(context),
      );
    }

    return VisibilityDetector(
      key: (widget.key)!,
      onVisibilityChanged: (VisibilityInfo info) {
        if (content.type == 'video') {
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
        }
      },
      child: GestureDetector(
        onDoubleTap: likeEffect,
        onTap: () {
          if (content.type == 'video') {
            if (_controller!.value.isPlaying) {
              isPaused = true;
              _controller!.pause();
            } else {
              isPaused = false;
              _controller!.play();
            }
          }
        },
        child: SizedBox(
          height: (screenHeight / 5.5) + 280,
          width: screenWidth,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: screenHeight / 1.8,
                  minWidth: screenWidth,
                  maxWidth: screenWidth,
                  minHeight: 100,
                ),
                child: () {
                  if (widget.content.type == 'image') {
                    return cacheImage(widget.content.url!, boxFit: BoxFit.fitWidth);
                  } else if (widget.content.type == 'video') {
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
                  }
                  return Text('error : ${widget.content.id}');
                }(),
              ),
              SizedBox(
                height: 80,
                width: 80,
                child: FlareActor(
                  'assets/instagram_like.flr',
                  controller: flareControls,
                  color: Colors.red.shade900,
                  animation: 'idle',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

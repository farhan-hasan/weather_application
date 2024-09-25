import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:networking_practice/config/app_themes.dart';
import 'package:networking_practice/feature/video_player/widgets/chewie_custom_controls.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  ValueNotifier<bool> isPlaying = ValueNotifier<bool>(false);
  ValueNotifier<bool> isBuffering = ValueNotifier<bool>(false);

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'));
    await _controller.initialize();
    _chewieController = ChewieController(
        hideControlsTimer: const Duration(seconds: 1),
        allowFullScreen: true,
        videoPlayerController: _controller,
        autoPlay: false,
        looping: false,
        customControls: ChewieCustomControls(
          controller: _controller,
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  doubleTapSeek(TapDownDetails details) {
    var x = details.globalPosition.dx;
    var width = MediaQuery.of(context).size.width;
    int currentPosition = _controller.value.position.inSeconds;
    if (x > (width / 2)) {
      _controller.seekTo(Duration(seconds: currentPosition + 10));
    } else if (x <= (width / 2)) {
      _controller.seekTo(Duration(seconds: currentPosition - 10));
    }
  }

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {});
    if (_controller.value.isCompleted) {
      _controller.seekTo(Duration.zero);
      isPlaying.value = false;
    }

    return Container(
      decoration: BoxDecoration(
          color: AppThemes.lightColorScheme.primary,
          //color: Colors.transparent,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Container(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Chewie(
                          controller: _chewieController,
                        ),
                        // Positioned(
                        //   bottom: 0,
                        //   child: Row(
                        //     children: [
                        //       IconButton(
                        //           onPressed: () {},
                        //           icon: const Icon(Icons.fast_rewind)),
                        //       _controller.value.isBuffering
                        //           ? const CircularProgressIndicator(
                        //               color: Colors.white,
                        //             )
                        //           : IconButton(
                        //               onPressed: () {
                        //                 if (_controller.value.isPlaying) {
                        //                   _controller.pause();
                        //                   isPlaying.value = false;
                        //                 } else {
                        //                   _controller.play();
                        //                   isPlaying.value = true;
                        //                 }
                        //               },
                        //               icon: Icon(
                        //                 _controller.value.isPlaying
                        //                     ? Icons.pause_circle
                        //                     : Icons.play_circle,
                        //                 size: 50,
                        //               )),
                        //       IconButton(
                        //           onPressed: () {},
                        //           icon: const Icon(Icons.fast_forward)),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 16,
                        //   child: VideoProgressIndicator(
                        //     padding: EdgeInsets.all(5),
                        //     _controller,
                        //     allowScrubbing: true,
                        //     colors: VideoProgressColors(
                        //       playedColor: AppThemes.lightColorScheme.primary,
                        //       backgroundColor: Colors.white,
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          )
        ],
      ),
    );
  }
}

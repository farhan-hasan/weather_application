import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:networking_practice/feature/video_player/widgets/chewie_custom_controls.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  VideoPlayerWidget({super.key, required this.url});

  String url;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget>
    with WidgetsBindingObserver {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  ValueNotifier<bool> isPlaying = ValueNotifier<bool>(false);
  ValueNotifier<bool> isBuffering = ValueNotifier<bool>(false);

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    print("------------------------->>>>>>>>>>>Inside videoplayer initstate");
    print("${widget.url}");
    _init();
  }

  _init() async {
    try {
      await _controller.dispose();
    } catch (e) {}
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url));
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
    WidgetsBinding.instance.removeObserver(this);
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
  void didUpdateWidget(covariant VideoPlayerWidget oldWidget) {
    // TODO: implement didUpdateWidget
    if (oldWidget.url != widget.url) {
      _init();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // _controller.addListener(() async {
    //   if (_controller.dataSource != widget.url) {
    //     _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    //     await _controller.initialize();
    //   }
    // });
    // if (_controller.value.isCompleted) {
    //   _controller.seekTo(Duration.zero);
    //   isPlaying.value = false;
    // }

    return Container(
      decoration: BoxDecoration(
          //color: AppThemes.lightColorScheme.primary,
          //color: Colors.transparent,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Container(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: Chewie(
                      controller: _chewieController,
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          )
        ],
      ),
    );
  }
}

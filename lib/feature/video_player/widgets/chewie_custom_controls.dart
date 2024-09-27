import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:networking_practice/feature/video_player/widgets/option_widget.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:video_player/video_player.dart';

class ChewieCustomControls extends StatefulWidget {
  ChewieCustomControls({super.key, required this.controller});

  final VideoPlayerController controller;

  @override
  State<ChewieCustomControls> createState() => _ChewieCustomControlsState();
}

class _ChewieCustomControlsState extends State<ChewieCustomControls> {
  ValueNotifier<Duration> postion = ValueNotifier<Duration>(Duration.zero);
  ValueNotifier<bool> isPlaying = ValueNotifier<bool>(false);
  ValueNotifier<double> playbackSpeed = ValueNotifier<double>(1.0);
  Duration duration = Duration.zero;
  late ChewieController _chewieController;

  // List<IconButton> options = [
  //   IconButton(onPressed: () {}, icon: Icon(Icons.list)),
  //   IconButton(onPressed: () {}, icon: Icon(Icons.list)),
  //   IconButton(onPressed: () {}, icon: Icon(Icons.list)),
  //   IconButton(onPressed: () {}, icon: Icon(Icons.list)),
  //   IconButton(onPressed: () {}, icon: Icon(Icons.list)),
  //   IconButton(onPressed: () {}, icon: Icon(Icons.list)),
  //   IconButton(onPressed: () {}, icon: Icon(Icons.list)),
  //   IconButton(onPressed: () {}, icon: Icon(Icons.list)),
  //   IconButton(onPressed: () {}, icon: Icon(Icons.list)),
  //   IconButton(onPressed: () {}, icon: Icon(Icons.list)),
  //   IconButton(onPressed: () {}, icon: Icon(Icons.list)),
  //   IconButton(onPressed: () {}, icon: Icon(Icons.list)),
  // ];

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _chewieController = ChewieController.of(context);
  }

  _init() {
    duration = widget.controller.value.duration;
    widget.controller.addListener(() {
      if (widget.controller.value.isPlaying) {
        isPlaying.value = true;
      } else {
        isPlaying.value = false;
      }
      postion.value = widget.controller.value.position;
    });
  }

  doubleTapSeek(TapDownDetails details) {
    var x = details.globalPosition.dx;
    var width = MediaQuery.of(context).size.width;
    int currentPosition =
        _chewieController.videoPlayerController.value.position.inSeconds;
    if (x > (width / 2)) {
      _chewieController.videoPlayerController
          .seekTo(Duration(seconds: currentPosition + 10));
    } else if (x <= (width / 2)) {
      _chewieController.videoPlayerController
          .seekTo(Duration(seconds: currentPosition - 10));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: Container(
              //color: Colors.blue.withOpacity(0.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ValueListenableBuilder(
                      valueListenable: playbackSpeed,
                      builder: (context, speed, child) {
                        return TextButton(
                            onPressed: () {
                              switch (speed) {
                                case 1.0:
                                  {
                                    _chewieController.videoPlayerController
                                        .setPlaybackSpeed(1.5);
                                    playbackSpeed.value = 1.5;
                                    break;
                                  }
                                case 1.5:
                                  {
                                    _chewieController.videoPlayerController
                                        .setPlaybackSpeed(2.0);
                                    playbackSpeed.value = 2.0;
                                    break;
                                  }
                                case 2.0:
                                  {
                                    _chewieController.videoPlayerController
                                        .setPlaybackSpeed(1.0);
                                    playbackSpeed.value = 1.0;
                                    break;
                                  }
                              }
                            },
                            child: Text(
                              "${speed}x",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 19),
                            ));
                      }),
                  IconButton(
                      onPressed: () {
                        _chewieController.toggleFullScreen();
                      },
                      icon: const Icon(Icons.screen_rotation)),
                ],
              ),
            ),
          ),
          Positioned(
              right: 0,
              child: IconButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      backgroundColor: Colors.black.withOpacity(0.2),
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            //height: MediaQuery.of(context).size.height / 2,
                            width: double.infinity,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Wrap(
                                    alignment: WrapAlignment.spaceAround,
                                    spacing: 10,
                                    runSpacing: 20,
                                    children: [
                                      optionWidget(
                                        title: "Audio Track",
                                        icon: Icons.audiotrack,
                                      ),
                                      optionWidget(
                                        title: "Subtitle",
                                        icon: Icons.subtitles,
                                      ),
                                      optionWidget(
                                        title: "Aspect Ratio",
                                        icon: Icons.aspect_ratio,
                                      ),
                                      optionWidget(
                                        title: "Display Settings",
                                        icon: Icons.display_settings,
                                      ),
                                      optionWidget(
                                        title: "Playlist",
                                        icon: Icons.playlist_play,
                                      ),
                                      optionWidget(
                                        title: "Network Stream",
                                        icon: Icons.wifi,
                                      ),
                                      optionWidget(
                                        title: "Information",
                                        icon: Icons.list,
                                      ),
                                      optionWidget(
                                        title: "Share",
                                        icon: Icons.share,
                                      ),
                                      optionWidget(
                                        title: "Cut",
                                        icon: Icons.cut,
                                      ),
                                      optionWidget(
                                        title: "Bookmark",
                                        icon: Icons.bookmarks_outlined,
                                      ),
                                      optionWidget(
                                        title: "Tutorial",
                                        icon: Icons.lightbulb,
                                      ),
                                      optionWidget(
                                        title: "More",
                                        icon: Icons.keyboard_arrow_right,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.more_vert))),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ValueListenableBuilder(
                  valueListenable: postion,
                  builder: (context, position, child) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                            "${position.inMinutes.toString()}:${((position.inSeconds) % 60).toString().padLeft(2, '0')}"),
                        Expanded(
                            child: Slider(
                          value: (position.inSeconds) < (duration.inSeconds)
                              ? (position).inSeconds.toDouble()
                              : (duration).inSeconds.toDouble(),
                          onChanged: (double value) {
                            widget.controller
                                .seekTo(Duration(seconds: value.toInt()));
                          },
                          max: duration.inSeconds.toDouble(),
                          min: 0,
                          activeColor: Colors.lightBlue,
                          inactiveColor: Colors.grey,
                        )),
                        Text(
                            "${widget.controller.value.duration.inMinutes.toString()}:${((widget.controller.value.duration.inSeconds) % 60).toString().padLeft(2, '0')}"),
                      ],
                    );
                  }),
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      child: Container(
                        //color: Colors.amber.withOpacity(0.5),
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.lock_open,
                              color: Colors.white,
                            )),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        //color: Colors.deepPurple.withOpacity(0.5),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.skip_previous,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                            ValueListenableBuilder(
                                valueListenable: isPlaying,
                                builder: (context, value, child) {
                                  return IconButton(
                                      onPressed: () {
                                        value == true
                                            ? widget.controller.pause()
                                            : widget.controller.play();
                                      },
                                      icon: Icon(
                                        value == true
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: Colors.white,
                                      ));
                                }),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.skip_next,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        //color: Colors.blue.withOpacity(0.5),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.fit_screen,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          GestureDetector(
            onVerticalDragUpdate: (dt) async {
              await controlSoundBrightness(dt, context);
            },
            onHorizontalDragUpdate: (dt) {
              dragControlSeekBar(dt);
            },
            onHorizontalDragEnd: (dt) {},
            onDoubleTapDown: (TapDownDetails details) => doubleTapSeek(details),
          )
        ],
      ),
    );
  }

  void dragControlSeekBar(DragUpdateDetails dt) {
    double v = dt.delta.dx;
    var time = _chewieController.videoPlayerController.value.position.inSeconds
        .toDouble();
    time += (0.5 * v);
    _chewieController.videoPlayerController
        .seekTo(Duration(seconds: time.toInt()));
  }

  Future<void> controlSoundBrightness(
      DragUpdateDetails dt, BuildContext context) async {
    print(dt.localPosition.dx);
    var width = MediaQuery.of(context).size.width;
    if (dt.localPosition.dx < width / 2) {
      print("left");
      print(dt.delta.dy);
      _chewieController.setVolume(dt.delta.dy * -1);
    } else {
      print("right");
      double brightness = await ScreenBrightness().system;
      print(brightness);
      var y = dt.delta.dy;
      if (y != 0) {
        double bright = await ScreenBrightness.instance.current;
        bright = bright + (y <= 0 ? 0.05 : -0.05);
        if (bright >= 0 && bright <= 1) {
          await ScreenBrightness.instance.setScreenBrightness(bright);
        }
      }
    }
  }
}

import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer player = AudioPlayer();

  PlayerState? _playerState;
  Duration? _duration;
  Duration? _position;

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  bool get _isPlaying => _playerState == PlayerState.playing;

  bool get _isPaused => _playerState == PlayerState.paused;

  String get _durationText => _duration?.toString().split('.').first ?? '';

  String get _positionText => _position?.toString().split('.').first ?? '';

  @override
  void initState() {
    super.initState();

    // Create the audio player.
    player = AudioPlayer();

    // Set the release mode to keep the source after playback has completed.
    player.setReleaseMode(ReleaseMode.stop);

    // Start the player as soon as the app is displayed.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await player.setSource(UrlSource(
          "https://instrumentalfx.co/wp-content/uploads/2017/10/Constricted.mp3"));
      await player.resume();
    });

    // Use initial values from player
    _playerState = player.state;
    player.getDuration().then(
          (value) => setState(() {
            _duration = value;
          }),
        );
    player.getCurrentPosition().then(
          (value) => setState(() {
            _position = value;
          }),
        );
    _initStreams();
  }

  void _initStreams() {
    _durationSubscription = player.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });

    _positionSubscription = player.onPositionChanged.listen(
      (p) => setState(() => _position = p),
    );

    _playerCompleteSubscription = player.onPlayerComplete.listen((event) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
      });
    });

    _playerStateChangeSubscription =
        player.onPlayerStateChanged.listen((state) {
      setState(() {
        _playerState = state;
      });
    });
  }

  Future<void> _play() async {
    await player.resume();
    setState(() => _playerState = PlayerState.playing);
  }

  Future<void> _pause() async {
    print("came in pause function");
    await player.pause();
    setState(() => _playerState = PlayerState.paused);
  }

  Future<void> _stop() async {
    await player.stop();
    setState(() {
      _playerState = PlayerState.stopped;
      _position = Duration.zero;
    });
  }

  @override
  void setState(VoidCallback fn) {
    // Subscriptions only can be closed asynchronously,
    // therefore events can occur after widget has been disposed.
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    player.dispose();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1E201E),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff1E201E),
        title: const Text(
          "Now Playing",
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.share)),
          IconButton(onPressed: () {}, icon: Icon(Icons.star_border)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                  //color: Colors.red,
                  child: const Icon(
                Icons.image,
                color: Colors.white,
                size: 300,
              )),
            ),
            Flexible(
              flex: 1,
              child: Container(
                //color: Colors.amberAccent,
                child: Column(
                  children: [
                    ListTile(
                      title: const Text(
                        "Audio Title",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Audio Subtitle",
                            style: TextStyle(
                                fontSize: 18, color: Colors.lightBlue[300]),
                          ),
                          const Text(
                            "Audio details",
                            style:
                                TextStyle(fontSize: 14, color: Colors.white70),
                          ),
                        ],
                      ),
                      trailing: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    // LinearProgressIndicator(
                    //   value: 2,
                    //   color: Colors.lightBlue[300],
                    //   minHeight: 10,
                    // ),
                    Slider(
                      activeColor: Colors.lightBlue[300],
                      inactiveColor: Colors.lightBlue[300],
                      onChanged: (value) {
                        final duration = _duration;
                        if (duration == null) {
                          return;
                        }
                        final position = value * duration.inMilliseconds;
                        player.seek(Duration(milliseconds: position.round()));
                      },
                      value: (_position != null &&
                              _duration != null &&
                              _position!.inMilliseconds > 0 &&
                              _position!.inMilliseconds <
                                  _duration!.inMilliseconds)
                          ? _position!.inMilliseconds /
                              _duration!.inMilliseconds
                          : 0.0,
                    ),
                    Text(
                      _position != null
                          ? '$_positionText / $_durationText'
                          : _duration != null
                              ? _durationText
                              : '',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _positionText,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          _durationText,
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.keyboard_arrow_down_sharp,
                            size: 40,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.fast_rewind,
                            size: 40,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                            icon: Icon(
                              _isPlaying == true
                                  ? Icons.pause_circle
                                  : Icons.play_circle,
                              size: 100,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              print(_isPlaying);
                              _isPlaying == true ? _pause : _play;
                            }),
                        IconButton(
                          icon: const Icon(
                            Icons.fast_forward_rounded,
                            size: 40,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.shuffle,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

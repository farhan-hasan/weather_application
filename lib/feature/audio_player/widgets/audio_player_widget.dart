import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AudioPlayerWidget extends StatefulWidget {
  AudioPlayerWidget({super.key});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final _player = AudioPlayer();
  static int _nextMediaId = 0;
  final _playlist = ConcatenatingAudioSource(
    children: [
      ClippingAudioSource(
        child: AudioSource.uri(Uri.parse(
            "https://instrumentalfx.co/wp-content/upload/11/Grand-Theft-Auto-San-Andreas-Theme-Song.mp3")),
        tag: MediaItem(
            artUri: Uri.parse(
                "https://wallpapers.com/images/hd/gta-sa-4k-main-character-hdglahkbi0d0wfjv.jpg"),
            id: "${_nextMediaId++}",
            title: 'GTA SA Intro',
            album: "Weather Album"),
      ),
      ClippingAudioSource(
          child: AudioSource.uri(Uri.parse(
              "https://instrumentalfx.co/wp-content/upload/11/Subway-Surfers-theme-song.mp3")),
          tag: MediaItem(
              artUri: Uri.parse(
                  "https://instrumentalfx.co/wp-content/uploads/2017/11/Subway-Surfers-theme.jpg"),
              id: "${_nextMediaId++}",
              title: 'Subway Surfers Introssssssssssssssssssssssssss',
              album: "Weather Album")),
    ],
  );
  Duration? position;
  Duration? duration;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    // Try to load audio from a source and catch any errors.
    try {
      // AAC example: https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.aac
      // await _player.setAudioSource(AudioSource.uri(
      //     tag: MediaItem(id: "1", title: "GTA SA"),
      //     Uri.parse(
      //         "https://instrumentalfx.co/wp-content/upload/11/Grand-Theft-Auto-San-Andreas-Theme-Song.mp3")));
      await _player.setAudioSource(_playlist);
    } on PlayerException catch (e) {
      print("Error loading audio source: $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int?>(
        stream: _player.currentIndexStream,
        builder: (context, snapshot) {
          var img =
              "https://img.freepik.com/premium-photo/white-wall-with-white-background-that-says-word-it_994023-371201.jpg";
          if (snapshot.hasData) {
            img = _playlist.sequence[snapshot.data!].tag.artUri.toString();
          }
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(img), opacity: .2, fit: BoxFit.cover),
                color: Colors.deepPurple[300],
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                StreamBuilder(
                    //stream: CombineLatestStream.list([player.onPositionChanged]),
                    stream: _player.positionStream,
                    builder: (context, positionSnapshot) {
                      if (positionSnapshot.hasData) {
                        position = positionSnapshot.data;
                        // print(
                        //     "Playback data ${position.toString()} - ${duration.toString()}");
                      }

                      return Slider(
                        activeColor: Colors.white,
                        inactiveColor: Colors.white,
                        onChanged: (value) {
                          print("value -> $value");

                          position = Duration(seconds: value.toInt());
                          _player.seek(position ?? Duration.zero);
                        },
                        value: (position?.inSeconds ?? 0) <
                                (duration?.inSeconds ?? 0)
                            ? (position ?? Duration.zero).inSeconds.toDouble()
                            : (duration ?? Duration.zero).inSeconds.toDouble(),
                        min: 0.0,
                        max: (duration ?? Duration.zero).inSeconds.toDouble(),
                      );
                    }),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${position?.inMinutes.toString() ?? "0:"}:${((position?.inSeconds ?? 0) % 60).toString().padLeft(2, '0')}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    StreamBuilder<int?>(
                        stream: _player.currentIndexStream,
                        builder: (context, snapshot) {
                          return Expanded(
                            child: Text(
                              "${snapshot.data == null ? "Track name" : _playlist.sequence[snapshot.data!].tag.title}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }),
                    const SizedBox(
                      width: 10,
                    ),
                    StreamBuilder<Duration?>(
                        stream: _player.durationStream,
                        builder: (context, snapshot) {
                          duration = Duration.zero;
                          if (snapshot.hasData) {
                            duration = snapshot.data;
                          }
                          return Text(
                            "${duration?.inMinutes.toString() ?? "0:"}:${((duration?.inSeconds ?? 0) % 60).toString().padLeft(2, '0')}",
                            style: const TextStyle(color: Colors.white),
                          );
                        })
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.keyboard_arrow_down_sharp,
                        size: 40,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    StreamBuilder<SequenceState?>(
                        stream: _player.sequenceStateStream,
                        builder: (context, snapshot) {
                          return IconButton(
                            icon: const Icon(
                              Icons.fast_rewind,
                              size: 40,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _player.hasPrevious
                                  ? {_player.seekToPrevious()}
                                  : null;
                            },
                          );
                        }),
                    StreamBuilder<PlayerState>(
                        stream: _player.playerStateStream,
                        builder: (context, snapshot) {
                          final playerState = snapshot.data;
                          final processingState = playerState?.processingState;
                          final playing = playerState?.playing ?? false;
                          if (processingState == ProcessingState.loading ||
                              processingState == ProcessingState.buffering) {
                            return const CircularProgressIndicator(
                              color: Colors.white,
                            );
                          } else {
                            return IconButton(
                                icon: Icon(
                                  processingState == ProcessingState.completed
                                      ? Icons.play_circle
                                      : playing == true
                                          ? Icons.pause_circle
                                          : Icons.play_circle,
                                  size: 100,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  print("playing = $playing");
                                  print("processing state = $processingState");
                                  if (processingState ==
                                      ProcessingState.ready) {
                                    if (!playing) {
                                      print("IN PAUSE");
                                      await _player.play();
                                    } else {
                                      _player.pause();
                                      print("IN PLAY");
                                    }
                                  } else if (processingState ==
                                      ProcessingState.completed) {
                                    _player.seek(Duration.zero);
                                    _player.play();
                                    print("IN LAST PLAY");
                                  }
                                });
                          }
                        }),
                    StreamBuilder(
                      builder: (context, snapshot) {
                        return IconButton(
                          icon: const Icon(
                            Icons.fast_forward_rounded,
                            size: 40,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _player.hasNext ? {_player.seekToNext()} : null;
                          },
                        );
                      },
                      stream: _player.sequenceStateStream,
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
          );
        });
  }
}

class DurationPosition {
  final Duration duration;
  final Duration position;

  DurationPosition({required this.duration, required this.position});

  @override
  String toString() {
    return 'Duration: ${duration.inSeconds} seconds, Position: ${position.inSeconds} seconds';
  }
}

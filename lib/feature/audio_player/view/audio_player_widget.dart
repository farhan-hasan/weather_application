import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerWidget extends StatefulWidget {
  AudioPlayerWidget({super.key});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final player = AudioPlayer();
  Duration? position;
  Duration? duration;

  Future<Duration?> getDuration() async {
    Duration? duration = await player.getDuration();
    return duration;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.deepPurple[200],
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          FutureBuilder(
            builder: (context, durationSnapshot) {
              return StreamBuilder(
                  //stream: CombineLatestStream.list([player.onPositionChanged]),
                  stream: player.onPositionChanged,
                  builder: (context, positionSnapshot) {
                    if (positionSnapshot.hasData && durationSnapshot.hasData) {
                      position = positionSnapshot.data;
                      duration = durationSnapshot.data;
                      // print(
                      //     "Playback data ${position.toString()} - ${duration.toString()}");
                    }

                    return Slider(
                      activeColor: Colors.white,
                      inactiveColor: Colors.white,
                      onChanged: (value) {
                        print("value -> $value");
                        position = Duration(seconds: value.toInt());
                        player.seek(position ?? Duration.zero);
                      },
                      value: (position?.inSeconds ?? 0) <
                              (duration?.inSeconds ?? 0)
                          ? (position ?? Duration.zero).inSeconds.toDouble()
                          : (duration ?? Duration.zero).inSeconds.toDouble(),
                      min: 0.0,
                      max: (duration ?? Duration.zero).inSeconds.toDouble(),
                    );
                  });
            },
            future: getDuration(),
          ),
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
              Text(
                "${duration?.inMinutes.toString() ?? "0:"}:${((duration?.inSeconds ?? 0) % 60).toString().padLeft(2, '0')}",
                style: const TextStyle(color: Colors.white),
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
              StreamBuilder<PlayerState>(
                  stream: player.onPlayerStateChanged,
                  builder: (context, snapshot) {
                    final playerState = snapshot.data ?? PlayerState.stopped;
                    return IconButton(
                        icon: Icon(
                          playerState == PlayerState.playing
                              ? Icons.pause_circle
                              : Icons.play_circle,
                          size: 100,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          if (playerState == PlayerState.playing) {
                            await player.pause();
                          } else if (playerState == PlayerState.paused) {
                            await player.resume();
                          } else {
                            await player.play(UrlSource(
                                "https://instrumentalfx.co/wp-content/upload/11/Grand-Theft-Auto-San-Andreas-Theme-Song.mp3"));
                          }
                        });
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
    );
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

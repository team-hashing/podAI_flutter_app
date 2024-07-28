import 'package:flutter/material.dart';
import 'package:podai/services/audio_service.dart';
import 'package:podai/models/models.dart';
import 'package:podai/widgets/widgets.dart';

class BottomPlayer extends StatefulWidget {
  const BottomPlayer({Key? key}) : super(key: key);

  @override
  State<BottomPlayer> createState() => _BottomPlayerState();
}

class _BottomPlayerState extends State<BottomPlayer> {
  final AudioService audioService = AudioService.instance;
  @override
  Widget build(BuildContext context) {
    return audioService.currentPodcastStream == null
        ? Container()
        : StreamBuilder<Podcast?>(
            stream: audioService.currentPodcastStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.purple[300],
                  ),
                  margin: const EdgeInsets.only(bottom: 30),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/podcast');
                    },
                    child: GestureDetector(
                      onVerticalDragUpdate: (details) {
                        // Check if the drag is downwards, details.delta.dy is positive when dragging down
                        if (details.delta.dy < 10) {
                          // Execute the desired action on sliding up
                          print('Sliding up');
                          Navigator.pushNamed(context, '/podcast');
                        } else if (details.delta.dy > 10) {
                          // Execute the desired action on sliding down
                          audioService.pause();
                          audioService.stopPositionListener();
                        }
                      },
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                snapshot.data!.name,
                                style: TextStyle(color: Colors.white),
                              ),
                              IconButton(
                                icon:
                                    Icon(Icons.replay_10, color: Colors.white),
                                onPressed: () =>
                                    audioService.seekBackward10Seconds(),
                              ),
                              StreamBuilder<bool>(
                                stream: audioService.isPlayingStream,
                                builder: (context, snapshot) {
                                  bool isPlaying = snapshot.data ?? false;
                                  return IconButton(
                                    icon: Icon(
                                      isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      if (isPlaying) {
                                        audioService.pause();
                                      } else {
                                        audioService.play();
                                      }
                                    },
                                  );
                                },
                              ),
                              IconButton(
                                icon:
                                    Icon(Icons.forward_10, color: Colors.white),
                                onPressed: () =>
                                    audioService.seekForward10Seconds(),
                              ),
                            ],
                          ),
                          StreamBuilder<SeekBarData>(
                            stream: audioService.seekBarDataStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final seekBarData = snapshot.data!;
                                return SeekBar(
                                  duration: seekBarData.duration,
                                  position: seekBarData.position,
                                  onChangeEnd: (newPosition) {
                                    audioService.seek(newPosition);
                                  },
                                  showTime: false,
                                );
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container(); // Empty container when there is no podcast playing
              }
            },
          );
  }
}

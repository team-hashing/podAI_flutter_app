import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

import '../widgets/widgets.dart';
import '../models/models.dart';


class PodcastScreen extends StatefulWidget {

  const PodcastScreen({super.key});

  @override
  State<PodcastScreen> createState() => _PodcastScreenState();
}

class _PodcastScreenState extends State<PodcastScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  
  Podcast podcast = Get.arguments ?? Podcast.podcasts.first;

  @override
  void initState() {
    super.initState();
    audioPlayer.setAudioSource(
      AudioSource.uri(
        Uri.parse('asset:///${podcast.url}'),
      ),
    );
    
  audioPlayer.durationStream.listen((duration) {
    if (duration != null) {
      int initialPositionMilliseconds = (podcast.progress * duration.inMilliseconds).toInt();
      Duration initialPosition = Duration(milliseconds: initialPositionMilliseconds);
      audioPlayer.seek(initialPosition);
    }
  });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Stream<SeekBarData> get _seekBarDataStream => 
    rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
      audioPlayer.positionStream,
      audioPlayer.durationStream,
      (Duration position, Duration? duration,) {
        return SeekBarData(position, duration ?? Duration.zero,);
      },
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Get.back();
          final currentPosition = audioPlayer.position;
          final totalDuration = audioPlayer.duration;
          final percentage = currentPosition.inMilliseconds / totalDuration!.inMilliseconds;
          podcast.progress = percentage;
          // Do something with the podcast duration
        },
      ),
      backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.purple[50],
      body:
        _AudioPlayer(podcast: podcast, seekBarDataStream: _seekBarDataStream, audioPlayer: audioPlayer),
    );
  }

}

class _AudioPlayer extends StatelessWidget {
  const _AudioPlayer({
    required this.podcast,
    required Stream<SeekBarData> seekBarDataStream,
    required this.audioPlayer,
  }) : _seekBarDataStream = seekBarDataStream;

  final Podcast podcast;
  final Stream<SeekBarData> _seekBarDataStream;
  final AudioPlayer audioPlayer;


  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: screenWidth * 0.9, // 80% of screen width
              width: screenWidth * 0.9, // 80% of screen width
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                  image: AssetImage(podcast.coverUrl),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Text(
            podcast.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            podcast.creator,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 20.0),
          StreamBuilder<SeekBarData>(
            stream: _seekBarDataStream, 
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              //final leftPosition = Duration(milliseconds: (podcast.progress * (positionData?.duration?.inMilliseconds ?? 0)).toInt());
              return SeekBar(position: positionData?.position ?? Duration.zero, duration: positionData?.duration ?? Duration.zero,onChangeEnd: audioPlayer.seek,);
            }),
            PlayerButtons(audioPlayer: audioPlayer)
        ],
      ),
    );
  }
}

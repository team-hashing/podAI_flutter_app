import 'package:flutter/material.dart';
import 'package:podai/models/models.dart';
import 'package:podai/services/services.dart';

class HorizontalPodcastCard extends StatelessWidget {
  final Podcast podcast;

  const HorizontalPodcastCard({super.key, required this.podcast});

  @override
  Widget build(BuildContext context) {
    AudioService audioService = AudioService.instance;
    Future<String> coverUrl = StoreService.instance.accessFile('BkofQvdg2EdktqL1tYfu', Types.cover);
    if (audioService.getCurrentPodcast() != null) {
      String coverUrl = StoreService.instance.accessFile(audioService.getCurrentPodcast()!.uuid, Types.cover) as String;
    }


    return GestureDetector(
        onTap: () {
          audioService.setCurrentPodcast(podcast);
          Navigator.pushNamed(context, '/podcast'); // Alternative navigation
        },
        child: StreamBuilder<Podcast?>(
          stream: audioService.currentPodcastStream,
          builder: (context, snapshot) {
            double progressStop = podcast.progress / podcast.duration;
            bool isCurrentPodcastPlaying = false;
            isCurrentPodcastPlaying =
                podcast.uuid == audioService.getCurrentPodcast()?.uuid;
            if (isCurrentPodcastPlaying && snapshot.hasData) {
              progressStop = snapshot.data!.progress / snapshot.data!.duration;
            }
            return StreamBuilder<SeekBarData>(
                stream: audioService.seekBarDataStream,
                builder: (context, snapshot) {
                  if (isCurrentPodcastPlaying && snapshot.hasData) {
                    final seekBarData = snapshot.data;
                    progressStop = (seekBarData!.position.inMilliseconds /
                        seekBarData!.duration.inMilliseconds);
                  }
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          15), // Match this with your Card's border radius
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 162, 35, 197)
                              .withOpacity(isCurrentPodcastPlaying ? 1 : 1),
                          const Color.fromARGB(
                              255, 250, 232, 255), // Progress color
                        ],
                        stops: [progressStop, progressStop],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Card(
                      color: isCurrentPodcastPlaying
                          ? Colors.purple[200]
                          : Colors.purple[
                              50], // Make the Card's background transparent
                      elevation: 0, // Remove shadow if not needed
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: SizedBox(
                                width: 60.0,
                                height: 60.0,
                                child: FutureBuilder<String>(
                                  future: coverUrl,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Image.network(
                                        snapshot.data!,
                                        fit: BoxFit.cover,
                                      );
                                    }
                                    return const CircularProgressIndicator();
                                  } 
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      podcast.title,
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      podcast.creator,
                                      style: const TextStyle(fontSize: 16.0),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4.0),
                                    // Additional content here
                                  ],
                                ),
                              ),
                            ),
                            StreamBuilder<bool>(
                                stream: audioService.isPlayingStream,
                                builder: (context, snapshot) {
                                  bool isPlaying = snapshot.data ?? false;
                                  return IconButton(
                                      icon: isCurrentPodcastPlaying && isPlaying
                                          ? Icon(Icons.pause_circle_filled)
                                          : Icon(Icons.play_circle_fill),
                                      iconSize: 48.0,
                                      onPressed: () {
                                        isCurrentPodcastPlaying
                                            ? (audioService.audioPlayer.playing
                                                ? audioService.pause()
                                                : audioService.play())
                                            : audioService
                                                .setCurrentPodcast(podcast);
                                      });
                                }),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
        ));
  }
}

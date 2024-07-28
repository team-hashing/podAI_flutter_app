import 'package:flutter/material.dart';
import 'package:podai/models/models.dart';
import 'package:podai/services/services.dart';

class HorizontalPodcastCard extends StatelessWidget {
  final Podcast podcast;
  const HorizontalPodcastCard({super.key, required this.podcast});

  @override
  Widget build(BuildContext context) {
    AudioService audioService = AudioService.instance;
    Future<String> coverUrl =
        StoreService.instance.accessFile(podcast.uuid, Types.cover);

    return GestureDetector(
      onTap: () {
        audioService.setCurrentPodcast(podcast).then((_) {
                                      audioService.loadPodcastProgress(podcast);
                                    });
        Navigator.pushNamed(context, '/podcast'); // Alternative navigation
      },
      child: StreamBuilder<Podcast?>(
        stream: audioService.currentPodcastStream,
        builder: (context, snapshot) {
          bool isCurrentPodcastPlaying =
              podcast.uuid == audioService.getCurrentPodcast()?.uuid;

          return FutureBuilder<String>(
            future: coverUrl,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _buildPlaceholder();
              } else if (snapshot.hasError) {
                return _buildErrorPlaceholder();
              } else if (snapshot.hasData) {
                return _buildContent(context, snapshot.data!,
                    isCurrentPodcastPlaying);
              } else {
                return _buildPlaceholder();
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[200],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: 60.0,
                height: 60.0,
                color: Colors.grey[300],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 20.0,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      width: 100.0,
                      height: 20.0,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      width: double.infinity,
                      height: 10.0,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[300],
      ),
      child: const Center(
        child: Icon(Icons.error, color: Colors.red),
      ),
    );
  }

  Widget _buildContent(BuildContext context, String coverUrl,
      bool isCurrentPodcastPlaying) {
    AudioService audioService = AudioService.instance;
    double progressStop = 0;
    return StreamBuilder<SeekBarData>(
      stream: audioService.seekBarDataStream,
      builder: (context, snapshot) {
        if (isCurrentPodcastPlaying && snapshot.hasData) {
          final seekBarData = snapshot.data;
          progressStop = (seekBarData!.position.inMilliseconds /
              seekBarData.duration.inMilliseconds);
        }
        return Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 162, 35, 197)
                    .withOpacity(isCurrentPodcastPlaying ? 1 : 0),
                const Color.fromARGB(255, 250, 232, 255),
              ],
              stops: [progressStop, progressStop],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Card(
            color: isCurrentPodcastPlaying
                ? Colors.purple[200]
                : null,
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: SizedBox(
                      width: 60.0,
                      height: 60.0,
                      child: Image.network(
                        coverUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return SizedBox(
                                  width: double.infinity,
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                );
                              }
                            },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            podcast.name,
                            style: const TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            podcast.creator,
                            style: isCurrentPodcastPlaying
                                ? const TextStyle(
                                    color: Color.fromARGB(255, 68, 68, 68))
                                : const TextStyle(color: Colors.grey),
                          ),
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
                                ? const Icon(Icons.pause_circle_filled)
                                : const Icon(Icons.play_circle_fill),
                            iconSize: 48.0,
                            onPressed: () {
                              isCurrentPodcastPlaying
                                  ? (audioService.audioPlayer.playing
                                      ? audioService.pause()
                                      : audioService.play())
                                  : audioService.setCurrentPodcast(podcast).then((_) {
                                      audioService.loadPodcastProgress(podcast);
                                    });
                            });
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

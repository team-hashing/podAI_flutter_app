import 'package:flutter/material.dart';
import 'package:podai/services/services.dart';
import 'package:podai/models/models.dart';

class PodcastCard extends StatelessWidget {
  final Podcast podcast;
  final double height;
  final double width;

  const PodcastCard({
    Key? key,
    required this.podcast,
    this.height = 200,
    this.width = 150,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AudioService audioService = AudioService.instance;
    Future<String> coverUrl =
        StoreService.instance.accessFile(podcast.uuid, Types.cover);

    return StreamBuilder<Podcast?>(
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
                return _buildContent(
                    context, snapshot.data!, isCurrentPodcastPlaying);
              } else {
                return _buildPlaceholder();
              }
            },
          );
        });
  }

  Widget _buildPlaceholder() {
  return Card(
    elevation: 4,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align elements to the start
        children: [
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[300],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 100,
            height: 20,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 4),
          Container(
            width: 60,
            height: 20,
            color: Colors.grey[300],
          ),
        ],
      ),
    ),
  );
}

  Widget _buildErrorPlaceholder() {
    return Container(
      width: width,
      height: height,
      color: Colors.red[300],
      child: const Center(
        child: Icon(Icons.error, color: Colors.white),
      ),
    );
  }

  Widget _buildContent(
      BuildContext context, String coverUrl, bool isCurrentPodcastPlaying) {
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
                      .withOpacity(isCurrentPodcastPlaying ? 1 : 1),
                  const Color.fromARGB(255, 250, 232, 255),
                ],
                stops: [progressStop, progressStop],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Card(
              color: isCurrentPodcastPlaying ? Colors.purple[200] : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  audioService.setCurrentPodcast(podcast).then((_) {
                                      audioService.loadPodcastProgress(podcast);
                                    });
                  Navigator.pushNamed(context, '/podcast');
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 50,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            width: double.infinity,
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
                      const SizedBox(height: 8),
                      Text(
                        podcast.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
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
            ),
          );
        });
  }
}

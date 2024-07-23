import 'package:flutter/material.dart';
import 'package:podai/models/models.dart';
import 'package:podai/services/services.dart';

// New PodcastCard Widget
class PodcastCard extends StatelessWidget {
  final Podcast podcast;
  final double height; // Added height parameter
  final double width; // Added width parameter

  const PodcastCard({
    Key? key,
    required this.podcast,
    required this.height, // Initialize height
    required this.width, // Initialize width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double minWidthForRegularView = 120;
    const double minHeightForRegularView = 180;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (width < minWidthForRegularView ||
            height < minHeightForRegularView) {
          return _buildCompactView(context, height, width);
        } else {
          return _buildRegularView(context, height, width);
        }
      },
    );
  }

  Widget _buildRegularView(BuildContext context, double height, double width) {
    AudioService audioService = AudioService.instance;

    
    Future<String> coverUrl = StoreService.instance.accessFile('BkofQvdg2EdktqL1tYfu', Types.cover);
    if (audioService.getCurrentPodcast() != null) {
      String coverUrl = StoreService.instance.accessFile(audioService.getCurrentPodcast()!.uuid, Types.cover) as String;
    }

    return StreamBuilder<Podcast?>(
      stream: audioService.currentPodcastStream,
      builder: (context, snapshot) {
        bool isCurrentPodcastPlaying =
            podcast.uuid == audioService.getCurrentPodcast()?.uuid;
        return Container(
          height: height,
          width: width,
          child: Card(
            color: isCurrentPodcastPlaying ? Colors.purple[200] : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                audioService.setCurrentPodcast(podcast);
                Navigator.pushNamed(context, '/podcast');
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 180,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
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
                    const SizedBox(height: 8),
                    Text(
                      podcast.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      podcast.creator,
                      style: isCurrentPodcastPlaying
                          ? TextStyle(
                              color: const Color.fromARGB(255, 68, 68, 68))
                          : TextStyle(color: Colors.grey),
                    ),
                    if (isCurrentPodcastPlaying)
                      StreamBuilder<SeekBarData>(
                          stream: audioService.seekBarDataStream,
                          builder: (context, snapshot) {
                            double progress = 0;
                            if (isCurrentPodcastPlaying && snapshot.hasData) {
                              final seekBarData = snapshot.data;
                              progress =
                                  seekBarData!.position.inMilliseconds /
                                      seekBarData!.duration.inMilliseconds;
                            }
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: LinearProgressIndicator(
                                value: progress,
                                backgroundColor: Colors.grey[300],
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.purple),
                              ),
                            );
                          })
                    else if (podcast.progress > 0)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: LinearProgressIndicator(
                          value: podcast.progress / podcast.duration,
                          backgroundColor: Colors.grey[300],
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.purple),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCompactView(BuildContext context, double height, double width) {
    AudioService audioService = AudioService.instance;
    
    Future<String> coverUrl = StoreService.instance.accessFile('BkofQvdg2EdktqL1tYfu', Types.cover);
    if (audioService.getCurrentPodcast() != null) {
      String coverUrl = StoreService.instance.accessFile(audioService.getCurrentPodcast()!.uuid, Types.cover) as String;
    }

    return StreamBuilder<Podcast?>(
        stream: audioService.currentPodcastStream,
        builder: (context, snapshot) {
          bool isCurrentPodcastPlaying =
              podcast.uuid == audioService.getCurrentPodcast()?.uuid;
          return Column(
            children: [
              Card(
                elevation: 2,
                child: InkWell(
                  onTap: () {
                    audioService.setCurrentPodcast(podcast);
                    Navigator.pushNamed(context, '/podcast');
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 180,
                        maxWidth: 120,
                      ),
                      child:FutureBuilder<String>(
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
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Text(
                  podcast.title,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        });
  }
}

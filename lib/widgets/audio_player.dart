import 'package:flutter/material.dart';
import 'package:podai/models/models.dart';
import 'package:podai/services/services.dart';
import 'package:podai/widgets/player_buttons.dart';
import 'package:podai/widgets/seekbar.dart';
import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({super.key});

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  bool isFavorite = false; // Step 1: State variable for favorite status

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    AudioService audioService = AudioService.instance;

    return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: FutureBuilder<String>(
              future: StoreService.instance.accessFile(
                  audioService.getCurrentPodcast()!.uuid, Types.cover),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  String coverUrl = snapshot.data!;
                    return Container(
                    height: screenWidth * 0.9,
                    width: screenWidth * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                      image: NetworkImage(coverUrl),
                      fit: BoxFit.cover,
                      ),
                      boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                      ],
                    ),
                    
                  );
                } else {
                  return Container(
                    width: screenWidth * 0.8,
                    height: screenWidth * 0.8,
                    color: Colors.grey,
                  );
                }
              },
            ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            audioService.getCurrentPodcast()!.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                            overflow:
                                TextOverflow.ellipsis, // Prevents text overflow
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            audioService.getCurrentPodcast()!.creator,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border),
                      color: Colors.red, // Optional: Customize color
                      onPressed: () {
                        setState(() {
                          isFavorite =
                              !isFavorite; // Step 3: Toggle favorite state
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () {
                        setState(() {
                          //TODO: create an URL for each podcast on frontend
                          //Share.share(audioService.getCurrentPodcast()?.url ?? '');
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                StreamBuilder<SeekBarData>(
                    stream: audioService.seekBarDataStream,
                    builder: (context, snapshot) {
                      final positionData = snapshot.data;
                      return SeekBar(
                        position: positionData?.position ?? Duration.zero,
                        duration: positionData?.duration ?? Duration.zero,
                        onChangeEnd: audioService.seek,
                      );
                    }),
                const SizedBox(height: 20.0),
                const PlayerButtons(),
                const SizedBox(height: 20.0),
              ],
            ),
          );
  }
}



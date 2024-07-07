import 'package:flutter/material.dart';
import 'package:podai/models/models.dart';

class HorizontalPodcastCard extends StatelessWidget {
  final Podcast podcast;

  const HorizontalPodcastCard({super.key, required this.podcast});

  @override
  Widget build(BuildContext context) {
    // Calculate the gradient stop based on the podcast progress
    double progressStop = podcast.progress; // Assuming this is a value between 0.0 and 1.0
    return GestureDetector( // Wrap with GestureDetector to detect taps
      onTap: () {
        Navigator.pushNamed(context, '/podcast', arguments: podcast); // Alternative navigation
      },
      child: Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15), // Match this with your Card's border radius
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 152, 76, 175).withOpacity(0.2), // Remaining progress color, adjust opacity as needed
            const Color.fromARGB(255, 250, 232, 255), // Progress color
          ],
          stops: [progressStop, progressStop],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Card(
        color: Colors.transparent, // Make the Card's background transparent
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
                  child: Image.asset(
                    podcast.coverUrl,
                    fit: BoxFit.cover,
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
                IconButton(
                  icon: const Icon(Icons.play_circle_fill),
                  iconSize: 48.0,
                  onPressed: () {
                    // Your play button action here
                  },)
            ],
          ),
        ),
      ),
    )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Ensure you have this import for navigation
import 'package:podai/models/models.dart';

// New PodcastCard Widget
class PodcastCard extends StatelessWidget {
  final Podcast podcast;

  const PodcastCard({Key? key, required this.podcast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Get.toNamed('/podcast', arguments: podcast);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    podcast.coverUrl,
                    fit: BoxFit.cover,
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
                style: const TextStyle(color: Colors.grey),
              ),
              if (podcast.progress > 0) // Check if progress is not 0
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: LinearProgressIndicator(
                    value: podcast.progress,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
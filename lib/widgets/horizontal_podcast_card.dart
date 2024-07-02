import 'package:flutter/material.dart';
import 'package:podai/models/models.dart';

class HorizontalPodcastCard extends StatelessWidget {
  final Podcast podcast;

  HorizontalPodcastCard({Key? key, required this.podcast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child:  SizedBox(
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
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      podcast.creator,
                      style: TextStyle(fontSize: 16.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.play_circle_fill),
              iconSize: 48.0,
              onPressed: () {
                // Add your play action here
              },
            ),
          ],
        ),
      ),
    );
  }
}
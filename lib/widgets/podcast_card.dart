import 'package:flutter/material.dart';
import 'package:podai/models/models.dart';

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
        if (width < minWidthForRegularView || height < minHeightForRegularView) {
          return _buildCompactView(context, height, width);
        } else {
          return _buildRegularView(context, height, width);
        }
      },
    );
  }
Widget _buildRegularView(BuildContext context, double height, double width) {
  return Container(
    height: height,
    width: width,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.pushNamed(context, '/podcast', arguments: podcast);
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
              if (podcast.progress > 0)
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
    ),
  );
}

  Widget _buildCompactView(BuildContext context, double height, double width) {
    // Implement a more compact view suitable for smaller spaces
    return Column(
      children: [
        Card(
          elevation: 2,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/podcast', arguments: podcast);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: 
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 180,
                  maxWidth: 120,
                ),
                child: Image.asset(
                  podcast.coverUrl,
                  fit: BoxFit.cover,
                // You might want to specify a height here to ensure the image fits well in a compact view
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
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
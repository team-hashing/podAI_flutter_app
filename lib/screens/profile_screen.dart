import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podai/widgets/profile_header.dart';
import '../models/podcast_model.dart'; // Assuming this is the path to your Podcast model
import '../widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  
  @override
  Widget build(BuildContext context) {
    final String username = "YourUsername";
    final String profileImageUrl = "assets/images/profile.png"; // Your profile image asset path
    return Scaffold(
      appBar: AppBar(
        title: Text(username),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Get.toNamed('/settings');
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          
          ProfileHeader(username: username, profileImageUrl: profileImageUrl),
          _buildSectionTitle('Keep Watching'),
          _buildPodcastSection(Podcast.keepWatching),
          _buildSectionTitle('Recommended for You'),
          _buildPodcastSection(Podcast.podcasts), // Assuming Podcast.podcasts contains recommended podcasts
          // Add more sections here
        ],
      ),
    );
  }

  
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
  Widget _buildPodcastSection(List<Podcast> podcasts) {
    return Container(
      height: 200, // Adjust based on your layout
      child: ListView(
        shrinkWrap: true, // This tells the ListView to size itself based on the children's sizes
        scrollDirection: Axis.horizontal,
        children: podcasts.map((podcast) => 
          SizedBox(
            width: 150, // Specify your desired width here
            child: PodcastCard(podcast: podcast),
          )
        ).toList(),
      ),
    );
}
}
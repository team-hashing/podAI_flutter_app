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
      child: ListView.builder(      
        shrinkWrap: true, // This tells the ListView to size itself based on the children's sizes
        scrollDirection: Axis.horizontal,
        itemCount: podcasts.length,
        itemBuilder: (context, index) {
          final podcast = podcasts[index];
          return Container(
            width: 160, // Adjust based on your layout
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      podcast.coverUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(podcast.title, overflow: TextOverflow.ellipsis),
                Text(podcast.creator, overflow: TextOverflow.ellipsis),
                if (podcast.progress != null)
                  LinearProgressIndicator(value: podcast.progress),
              ],
            ),
          );
        },
      ),
    );
  }
}
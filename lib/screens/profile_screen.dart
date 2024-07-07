import 'package:flutter/material.dart';
import 'package:podai/models/models.dart';
import 'package:podai/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String username = "YourUsername";
    const String profileImageUrl = "assets/images/profile/profile.png";

    return Scaffold(
      appBar: AppBar(
        title: const Text(username),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          const ProfileHeader(username: username, profileImageUrl: profileImageUrl),
          PodcastSection(
            podcasts: Podcast.keepWatching,
            title: 'Keep Watching',
            titleStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          PodcastSection(
            podcasts: Podcast.podcasts.take(4).toList(),
            displayType: DisplayType.grid,
            height: 200,
            gridCrossAxisCount: 2,
            title: 'Recommended',
            titleStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
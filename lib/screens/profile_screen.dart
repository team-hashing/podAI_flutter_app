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
        title: const Text('Profile'),
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
          ProfileHeader(username: username, profileImageUrl: profileImageUrl)
        ],
      ),
    );
  }
}
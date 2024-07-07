import 'package:flutter/material.dart';
import 'package:podai/models/models.dart';



class ProfileHeader extends StatelessWidget {
  final String username;
  final String profileImageUrl;

  const ProfileHeader({
    Key? key,
    required this.username,
    required this.profileImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(profileImageUrl),
          ),
        ),
        Text(
          username,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
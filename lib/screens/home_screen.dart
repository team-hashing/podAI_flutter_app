import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podai/models/models.dart';
import 'package:podai/widgets/widgets.dart';




class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
            children: Podcast.podcasts.map((podcast) => PodcastCard(podcast: podcast)).toList(),
          ),
        ),
    );
  }
}
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
      body: 
      SingleChildScrollView(
        child: Column(
          children: List.from(
            [PodcastSection(	
              podcasts: Podcast.podcasts,
              displayType: DisplayType.grid,
              gridCrossAxisCount: 2,
              title: 'Recommended',
            ),
            PodcastSection(
              podcasts: Podcast.podcasts,
              displayType: DisplayType.list,
              title: 'Trending',
            ),
            PodcastSection(
              podcasts: Podcast.podcasts,
              displayType: DisplayType.cards,
              title: 'New Releases',
            ),
            ],
          ),
        ),
      ),
    );
  }
}
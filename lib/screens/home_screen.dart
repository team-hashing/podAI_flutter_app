import 'package:flutter/material.dart';
import 'package:podai/models/models.dart';
import 'package:podai/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearching = false;
  List<Podcast> searchResults = [];
  TextEditingController searchController = TextEditingController();

  void startSearch() {
    setState(() {
      isSearching = true;
      searchResults.addAll(Podcast.podcasts);
    });
  }

  void cancelSearch() {
    setState(() {
      isSearching = false;
      searchController.clear();
      searchResults.clear();
    });
  }

  void searchPodcasts(String query) {
    if (query.isEmpty) {
      setState(() {
        searchResults.addAll(Podcast.podcasts);
      });
      return;
    }
    final results = Podcast.podcasts.where((podcast) {
      final titleLower = podcast.title.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: isSearching
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: cancelSearch,
              )
            : null,
        backgroundColor: Colors.transparent,
        title: isSearching
            ? TextField(
                controller: searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search Podcasts...',
                  border: InputBorder.none,
                ),
                onChanged: searchPodcasts,
              )
            : null,
        actions: isSearching
            ? []
            : [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: startSearch,
                ),
              ],
      ),
      body: isSearching
          ? ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final podcast = searchResults[index];
                return HorizontalPodcastCard(podcast: podcast);
              },
            ) : SingleChildScrollView(
        child: Column(
          children: List.from(
            [PodcastSection(	
              podcasts: Podcast.keepWatching,
              displayType: DisplayType.grid,
              gridCrossAxisCount: 3,
              title: 'Recommended',
            ),
            PodcastSection(
              podcasts: Podcast.keepWatching,
              displayType: DisplayType.list,
              title: 'Trending',
            ),
            PodcastSection(
              podcasts: Podcast.keepWatching,
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
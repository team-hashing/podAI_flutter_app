import 'package:flutter/material.dart';
import 'package:podai/models/models.dart';
import 'package:podai/services/services.dart';
import 'package:podai/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Podcast> podcasts = [];

  @override
  void initState() {
    super.initState();
    loadPodcasts();
  }

  void loadPodcasts() async {
    List<Podcast> podcasts = await DatabaseService.instance.fetchAllPodcasts();
    setState(() {});
  }


bool isSearching = false;
List<Podcast> searchResults = [];
TextEditingController searchController = TextEditingController();


void startSearch() async {
  List<Podcast> podcasts = await DatabaseService.instance.fetchAllPodcasts();
  setState(() {
    isSearching = true;
    searchResults.addAll(podcasts);
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
        searchResults.addAll(podcasts);
      });
      return;
    }
    final results = podcasts.where((podcast) {
      final titleLower = podcast.name.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    AudioService audioService = AudioService.instance;
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
                decoration: const InputDecoration(
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
      body: Stack(
        children: [
          isSearching
          ? ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final podcast = searchResults[index];
                return HorizontalPodcastCard(podcast: podcast);
              },
            ) : 
          SingleChildScrollView(
            
            padding: EdgeInsets.only(bottom: audioService.getCurrentPodcast() != null ? 200:0),
            child: Column(
              children: [
                PodcastSection(
                  key: const Key('recommended_section'),
                  displayType: DisplayType.grid,
                  gridCrossAxisCount: 3,
                  title: 'Recommended',
                ),
                PodcastSection(
                  key: const Key('trending_section'),
                  displayType: DisplayType.list,
                  title: 'Trending',
                ),
                PodcastSection(
                  key: const Key('new_releases_section'),
                  displayType: DisplayType.cards,
                  title: 'New Releases',
                  podcastType: PodcastType.user,
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}

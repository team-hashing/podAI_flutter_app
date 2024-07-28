import 'dart:math';
import 'package:flutter/material.dart';
import 'package:podai/widgets/widgets.dart';
import 'package:podai/models/models.dart';
import 'package:podai/services/services.dart';

// Define an enum for the display types
enum DisplayType { cards, grid, list }
enum PodcastType { user, popular }

class PodcastSection extends StatefulWidget {
  final double itemWidth;
  final int gridCrossAxisCount;
  final double gridChildAspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final String? title;
  final TextStyle? titleStyle;
  final EdgeInsetsGeometry padding;
  final double height;
  final DisplayType displayType;
  final PodcastType podcastType;

  const PodcastSection({
    Key? key,
    this.itemWidth = 150,
    this.gridCrossAxisCount = 2,
    this.gridChildAspectRatio = .8,
    this.crossAxisSpacing = 10,
    this.mainAxisSpacing = 10,
    this.title,
    this.titleStyle,
    this.padding = const EdgeInsets.all(10),
    this.height = 200,
    this.displayType = DisplayType.cards,
    this.podcastType = PodcastType.popular,
  }) : super(key: key);

  @override
  _PodcastSectionState createState() => _PodcastSectionState();
}


class _PodcastSectionState extends State<PodcastSection> {
  List<Podcast> podcasts = [];

  @override
  void initState() {
    super.initState();
    loadPodcasts();
  }

  void loadPodcasts() async {
    List<Podcast> fetchedPodcasts;
    if (widget.podcastType == PodcastType.user) {
      fetchedPodcasts = await FetchPodcastsService().fetchPodcastsByCreator();
    } else {
      fetchedPodcasts = await FetchPodcastsService().fetchAllPodcasts();
    }
    setState(() {
      podcasts = fetchedPodcasts;
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget content;

    switch (widget.displayType) {
      case DisplayType.grid:
        double screenWidth = MediaQuery.of(context).size.width;
        double itemWidth = (screenWidth - (widget.crossAxisSpacing * (widget.gridCrossAxisCount - 1))) / widget.gridCrossAxisCount;
        content = GridView.count(
          crossAxisCount: widget.gridCrossAxisCount,
          childAspectRatio: widget.gridChildAspectRatio,
          crossAxisSpacing: widget.crossAxisSpacing,
          mainAxisSpacing: widget.mainAxisSpacing,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: podcasts.map((podcast) => SizedBox(
            width: itemWidth,
            height: widget.height,
            child: PodcastCard(key: Key(podcast.uuid), podcast: podcast, height: widget.height, width: itemWidth),
          )).toList(),
        );
        break;
      case DisplayType.list:
        content = Column(
          children: podcasts.map((podcast) => HorizontalPodcastCard(key: Key(podcast.uuid), podcast: podcast)).toList(),
        );
        break;
      case DisplayType.cards:
  content = Container(
    height: widget.height,
    child: ListView(
      padding: widget.padding,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: podcasts.map((podcast) => SizedBox(
        width: widget.itemWidth,
        height: widget.height,
        child: PodcastCard(
          key: Key(podcast.uuid),
          podcast: podcast,
          height: widget.height,
          width: widget.itemWidth,
        ),
      )).toList(),
    ),
  );
  break;
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 8),
              child: Text(widget.title!, style: widget.titleStyle ?? TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            content,
        ],
    );
  }
}
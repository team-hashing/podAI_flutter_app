import 'dart:math';
import 'package:flutter/material.dart';
import 'package:podai/widgets/widgets.dart';
import 'package:podai/models/models.dart';

// Define an enum for the display types
enum DisplayType { cards, grid, list }

class PodcastSection extends StatelessWidget {
  final List<Podcast> podcasts;
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

  const PodcastSection({
    Key? key,
    required this.podcasts,
    this.itemWidth = 150,
    this.gridCrossAxisCount = 2,
    this.gridChildAspectRatio = .8,
    this.crossAxisSpacing = 10,
    this.mainAxisSpacing = 10,
    this.title,
    this.titleStyle,
    this.padding = const EdgeInsets.all(10),
    this.height = 200,
    this.displayType = DisplayType.cards, // Default to cards
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget content;

    switch (displayType) {
      case DisplayType.grid:
        double screenWidth = MediaQuery.of(context).size.width;
        double itemWidth = (screenWidth - (crossAxisSpacing * (gridCrossAxisCount - 1))) / gridCrossAxisCount;
        content = GridView.count(
          crossAxisCount: gridCrossAxisCount,
          childAspectRatio: gridChildAspectRatio,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: podcasts.map((podcast) => SizedBox(
            width: itemWidth,
            height: height,
            child: PodcastCard(podcast: podcast, height: height, width: itemWidth),
          )).toList(),
        );
        break;
      case DisplayType.list:
        content = Column(
          children: podcasts.map((podcast) => HorizontalPodcastCard(podcast: podcast)).toList(),
        );
        break;
      case DisplayType.cards:
      default:
        content = 
              Container(
                height: height,
                child: ListView(
                  padding: padding,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: podcasts.map((podcast) => PodcastCard(podcast: podcast, height: height, width: itemWidth),
                  ).toList(),
                ),
              );
        break;
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 8),
              child: Text(title!, style: titleStyle ?? TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            content,
        ],
    );
  }
}
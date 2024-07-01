class Podcast {
  final String title;
  final String creator;
  final String url;
  final String coverUrl;

  Podcast({
    required this.title,
    required this.creator,
    required this.url,
    required this.coverUrl,
  });
  
  static List<Podcast> podcasts = [
    Podcast(
      title: 'The Joe Rogan Experience',
      creator: 'Joe Rogan',
      url: 'assets/audio/podcast.wav',
      coverUrl: 'assets/images/covers/cover.png',
    ),
  ];
}

class Podcast {
  final String title;
  final String creator;
  final String url;
  final String coverUrl;
  double progress;

  Podcast({
    required this.title,
    required this.creator,
    required this.url,
    required this.coverUrl,
    this.progress = 0.0,
  });
  
  static List<Podcast> podcasts = [
    Podcast(
      title: 'The Joe Rogan Experience',
      creator: 'Joe Rogan',
      url: 'assets/audio/podcast.wav',
      coverUrl: 'assets/images/covers/cover.png',
    ),
    Podcast(
      title: 'The Joe Rogan Experience 2',
      creator: 'Joe Rogan',
      url: 'assets/audio/podcast.wav',
      coverUrl: 'assets/images/covers/cover.png',
    ),
    Podcast(
      title: 'The Joe Rogan Experience 2',
      creator: 'Joe Rogan',
      url: 'assets/audio/podcast.wav',
      coverUrl: 'assets/images/covers/cover.png',
    ),
    Podcast(
      title: 'The Joe Rogan Experience 2',
      creator: 'Joe Rogan',
      url: 'assets/audio/podcast.wav',
      coverUrl: 'assets/images/covers/cover.png',
    ),
    Podcast(
      title: 'The Joe Rogan Experience 2',
      creator: 'Joe Rogan',
      url: 'assets/audio/podcast.wav',
      coverUrl: 'assets/images/covers/cover.png',
    ),
    Podcast(
      title: 'The Joe Rogan Experience 2',
      creator: 'Joe Rogan',
      url: 'assets/audio/podcast.wav',
      coverUrl: 'assets/images/covers/cover.png',
    ),
    Podcast(
      title: 'The Joe Rogan Experience 2',
      creator: 'Joe Rogan',
      url: 'assets/audio/podcast.wav',
      coverUrl: 'assets/images/covers/cover.png',
    ),
    Podcast(
      title: 'The Joe Rogan Experience 2',
      creator: 'Joe Rogan',
      url: 'assets/audio/podcast.wav',
      coverUrl: 'assets/images/covers/cover.png',
    ),
    Podcast(
      title: 'The Joe Rogan Experience 2',
      creator: 'Joe Rogan',
      url: 'assets/audio/podcast.wav',
      coverUrl: 'assets/images/covers/cover.png',
    ),
  ];

  
  static List<Podcast> keepWatching = [
    Podcast(
      title: 'The Joe Rogan Experience',
      creator: 'Joe Rogan',
      url: 'assets/audio/podcast.wav',
      coverUrl: 'assets/images/covers/cover.png',
      progress: 0.5, // 50% watched
      ),
    Podcast(
      title: 'The Joe Rogan Experience',
      creator: 'Joe Rogan',
      url: 'assets/audio/podcast.wav',
      coverUrl: 'assets/images/covers/cover.png',
      progress: 0.5,
      ),
      
    Podcast(
      title: 'The Joe Rogan Experience',
      creator: 'Joe Rogan',
      url: 'assets/audio/podcast.wav',
      coverUrl: 'assets/images/covers/cover.png',
      progress: 0.5,
      ),
    Podcast(
      title: 'The Joe Rogan Experience',
      creator: 'Joe Rogan',
      url: 'assets/audio/podcast.wav',
      coverUrl: 'assets/images/covers/cover.png',
      progress: 0.5,
      ),
      ];

}

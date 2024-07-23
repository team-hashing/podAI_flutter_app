class Podcast {
  final String uuid;
  final String title;
  final String creator;
  final int duration;
  late final int progress;
  DateTime createdAt;
  int likes;
  List<String> likedBy;

  Podcast({
    required this.uuid,
    required this.title,
    required this.creator,
    required this.progress,
    required this.duration,
    required this.createdAt,
    required this.likes,
    required this.likedBy,
  });

  // Convert a Podcast object into a map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'creator': creator,
      'progress': progress,
      'duration': duration,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'likes': likes,
      'likedBy': likedBy,
    };
  }
  
  // Create a Podcast object from a map
  factory Podcast.fromMap(Map<String, dynamic> map, String uuid) {
    return Podcast(
      uuid: uuid,
      title: map['title'],
      creator: map['creator'],
      progress: map['progress'],
      duration: map['duration'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      likes: map['likes'],
      likedBy: List<String>.from(map['likedBy']),
    );
  }


  static List<Podcast> podcastMocks = [
    Podcast(
      uuid: 'BkofQvdg2EdktqL1tYfu',
      title: 'The first podcast',
      creator: 'John Doe',
      progress: 0,
      duration: 1000,
      createdAt: DateTime.now(),
      likes: 0,
      likedBy: [],
    ),
    Podcast(
      uuid: '2',
      title: 'The second podcast',
      creator: 'Jane Doe',
      progress: 0,
      duration: 1000,
      createdAt: DateTime.now(),
      likes: 0,
      likedBy: [],
    ),
    Podcast(
      uuid: '3',
      title: 'The third podcast',
      creator: 'John Doe',
      progress: 0,
      duration: 1000,
      createdAt: DateTime.now(),
      likes: 0,
      likedBy: [],
    ),
    Podcast(
      uuid: '4',
      title: 'The fourth podcast',
      creator: 'Jane Doe',
      progress: 0,
      duration: 1000,
      createdAt: DateTime.now(),
      likes: 0,
      likedBy: [],
    ),
    Podcast(
      uuid: '5',
      title: 'The fifth podcast',
      creator: 'John Doe',
      progress: 0,
      duration: 1000,
      createdAt: DateTime.now(),
      likes: 0,
      likedBy: [],
    ),
    Podcast(
      uuid: '6',
      title: 'The sixth podcast',
      creator: 'Jane Doe',
      progress: 0,
      duration: 1000,
      createdAt: DateTime.now(),
      likes: 0,
      likedBy: [],
    ),
  ];

}
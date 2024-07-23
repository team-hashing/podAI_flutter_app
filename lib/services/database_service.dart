import 'package:firebase_database/firebase_database.dart';
import 'package:podai/models/models.dart';

class DatabaseService {
  DatabaseService._privateConstructor();
  static final DatabaseService _instance = DatabaseService._privateConstructor();

  static DatabaseService get instance => _instance; 

  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  // Fetch all podcasts
  Future<List<Podcast>> fetchAllPodcasts() async {
    DataSnapshot snapshot = await _dbRef.child('podcasts').get();
    if (snapshot.exists && snapshot.value is Map) {
      List<Podcast> podcasts = [];
      Map<String, dynamic> podcastsMap = Map<String, dynamic>.from(snapshot.value as Map);
      podcastsMap.forEach((key, value) {
        final podcast = Podcast.fromMap(Map<String, dynamic>.from(value), key);
        podcasts.add(podcast);
      });
      return podcasts;
    } else {
      return [];
    }
  }

  // Add a new podcast
  Future<void> addPodcast(Podcast podcast) async {
    await _dbRef.child('podcasts').child(podcast.uuid).set(podcast.toMap());
  }

  // Update a podcast's progress
  Future<void> updatePodcastProgress(String uuid, String progress) async {
    await _dbRef.child('podcasts').child(uuid).update({'progress': progress});
  }

}
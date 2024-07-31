import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:podai/models/podcast_model.dart';
import 'package:podai/services/audio_service.dart';
import 'package:podai/services/auth_service.dart';
import 'package:podai/services/cache_service.dart';

class FetchPodcastsService {
  final String url_by_likes =
      'http://34.170.203.169:8000/api/podcasts_by_likes';
  final String url_creator = 'http://34.170.203.169:8000/api/podcasts';
  String userId = AuthService().getCurrentUser()!.uid;

  Future<List<Podcast>> fetchAllPodcasts() async {
    List<Podcast> cachedPodcasts =
        await CacheService.instance.getCachedPodcasts('popular_podcasts');
    if (cachedPodcasts.isNotEmpty) {
      return cachedPodcasts;
    }
    try {
      final Map<String, String> body = {
        'user_id': userId,
      };
      final response = await http.post(
        Uri.parse(url_by_likes),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Future<Podcast>> podcastFutures = data
            .map((podcast) => Podcast.fromMap(podcast, podcast['id']))
            .toList();
        List<Podcast> podcasts = await Future.wait(podcastFutures);
        await AudioService.instance.loadAllPodcastProgress(podcasts);
        await CacheService.instance.cachePodcasts('popular_podcasts', podcasts);
        return podcasts;
      } else {
        print('Failed to fetch podcasts. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching podcasts: $e');
      return [];
    }
  }

  Future<List<Podcast>> fetchPodcastsByCreator() async {
    List<Podcast> cachedPodcasts =
        await CacheService.instance.getCachedPodcasts('user_podcasts');
    if (cachedPodcasts.isNotEmpty) {
      return cachedPodcasts;
    }

    try {
      final Map<String, String> body = {
        'user_id': userId,
      };
      final response = await http.post(
        Uri.parse(url_creator),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Future<Podcast>> podcastFutures = data
            .map((podcast) => Podcast.fromMap(podcast, podcast['id']))
            .toList();
        List<Podcast> podcasts = await Future.wait(podcastFutures);
        await AudioService.instance.loadAllPodcastProgress(podcasts);
        await CacheService.instance.cachePodcasts('user_podcasts', podcasts);
        return podcasts;
      } else {
        print('Failed to fetch podcasts. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching podcasts: $e');
      return [];
    }
  }
}

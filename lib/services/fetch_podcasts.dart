import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:podai/models/podcast_model.dart';
import 'package:podai/services/audio_service.dart';
import 'package:podai/services/auth_service.dart';

class FetchPodcastsService {
  final String url_by_likes = 'http://34.170.203.169:8000/api/podcasts_by_likes';
  final String url_creator = 'http://34.170.203.169:8000/api/podcasts';
  String userId = AuthService().getCurrentUser()!.uid;

  Future<List<Podcast>> fetchAllPodcasts() async {
    try {
      final Map<String, String> body = {
        'user_id': userId,
      };
      final response = await http.post(
        Uri.parse(url_by_likes),
        headers: {'Content-Type': 'application/json'}, // Set the content type to JSON
        body: jsonEncode(body), // Encode the body to JSON
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Podcast> podcasts = data.map((podcast) => Podcast.fromMap(podcast, podcast['id'])).toList();
        await AudioService.instance.loadAllPodcastProgress(podcasts);
        return podcasts;
      } else {
        // Handle error
        print('Failed to fetch podcasts. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Handle exception
      print('Error fetching podcasts: $e');
      return [];
    }
  }

  Future<List<Podcast>> fetchPodcastsByCreator() async {
    try {
      final Map<String, String> body = {
        'user_id': userId,
      };
      final response = await http.post(
        Uri.parse(url_creator),
        headers: {'Content-Type': 'application/json'}, // Set the content type to JSON
        body: jsonEncode(body), // Encode the body to JSON
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Podcast> podcasts = data.map((podcast) => Podcast.fromMap(podcast, podcast['id'])).toList();
        await AudioService.instance.loadAllPodcastProgress(podcasts);
        return podcasts;
      } else {
        // Handle error
        print('Failed to fetch podcasts. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Handle exception
      print('Error fetching podcasts: $e');
      return [];
    }
  }
}
import 'dart:convert';
import 'package:http/http.dart' as http;

class VideoModelApi {
  String? key;
  VideoModelApi({required this.key});
  factory VideoModelApi.fromJson(Map<String, dynamic> video) {
    return VideoModelApi(key: video['key']);
  }
  static Future<List<VideoModelApi>> fetchVideo(int id) async {
    final response = await http
        .get(Uri.parse("https://api.themoviedb.org/3/movie/$id/videos?api_key=769e3e5bd31b49abd2890731828ba046"));
    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body)['results'];
      return json.map((e) => VideoModelApi.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }
}


class Movie {
  final int id;
  final List<dynamic> results;

  Movie({required this.id, required this.results});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      results: json['results'],
    );
  }
}

class MovieAPI {
  final String apiKey;
  final String baseUrl = "https://api.themoviedb.org/3/movie/";

  MovieAPI({required this.apiKey});

  Future<String?> getMovieKey(int movieId) async {
    final url = "$baseUrl$movieId/videos?api_key=$apiKey";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData['results'] != null && jsonData['results'].length > 0) {
        final result = jsonData['results'][0];

        if (result['key'] != null) {
          return result['key'];
        }
      }
    }

    return null;
  }
}
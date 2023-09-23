import 'package:movie/Provider/FireBase/firebase_function.dart';
import 'package:provider/provider.dart';

class PopularMoviesModel {
  bool? adult;
  String? idFirebase;
  bool isMarked;
  String backdrop_path;
  List<int>? genre_ids;
  int id;
  String overview;
  num? popularity;
  String poster_path;
  String release_date;
  String title;
  num? vote_average;
  num? vote_count;
  PopularMoviesModel(
      {
         this.isMarked = true,
        this.idFirebase ='',
      required this.title,
      required this.id,
      required this.adult,
      required this.backdrop_path,
      required this.genre_ids,
      required this.overview,
      required this.popularity,
      required this.poster_path,
      required this.release_date,
      required this.vote_average,
      required this.vote_count});
  factory PopularMoviesModel.fromJson(Map<String, dynamic> jsonData) {
    return PopularMoviesModel(
        idFirebase: jsonData['idFirebase'],
        title: jsonData['title'] ?? 'UNKNOWN',
        id: jsonData['id'] ?? 'UNKNOWN',
        adult: jsonData['adult'] ?? 'UNKNOWN',
        backdrop_path: jsonData['backdrop_path'] ?? "",
        genre_ids: List<int>.from(jsonData['genre_ids']),
        // original_itle: jsonData['original_itle'],
        overview: jsonData['overview'] ?? 'UNKNOWN',
        popularity: jsonData['popularity'] ?? 'UNKNOWN',
        poster_path: jsonData['poster_path'] ?? 'UNKNOWN',
        release_date: jsonData['release_date'] ?? 'UNKNOWN',
        vote_average: jsonData['vote_average'] ?? 'UNKNOWN',
        vote_count: jsonData['vote_count'] ?? 'UNKNOWN');
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
      'idFirebase': idFirebase,
      'adult': adult,
      'backdrop_path': backdrop_path,
      'genre_ids': genre_ids,
      'overview': overview,
      'popularity': popularity,
      'poster_path': poster_path,
      'release_date': release_date,
      'vote_average': vote_average,
      'vote_count': vote_count,
    };
  }
}

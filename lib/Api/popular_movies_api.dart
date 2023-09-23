import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie/Models/category_name_model.dart';

import 'package:movie/Models/popular_movies_model.dart';
import 'package:movie/const.dart';

class PopularMoviesApi {
  Future<List<CategoryNameModel>> fetchCategoryName(String api) async {
    final response = await http.get(Uri.parse(api));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body)['genres'];
      return jsonList.map((json) => CategoryNameModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }


  Future<List<PopularMoviesModel>> fetchData(String api) async {
    final response = await http.get(Uri.parse(api));
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body)['results'] as List<dynamic>;
      print(jsonList.map((json) => PopularMoviesModel.fromJson(json)).toList());

      return jsonList.map((json) => PopularMoviesModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }

  Future<List<PopularMoviesModel>> fetchSimilar(int id) async {
    final response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/$id/similar?api_key=769e3e5bd31b49abd2890731828ba046"));
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body)['results'] as List<dynamic>;
      // print(jsonList.map((json) => PopularMoviesModel.fromJson(json)).toList());

      return jsonList.map((json) => PopularMoviesModel.fromJson(json)).toList();
    } else {
      throw Exception(Exception);
    }
  }

  Future<List<PopularMoviesModel>> fetchCategoryMovies(
      {required int id}) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/discover/movie?with_genres=$id&api_key=769e3e5bd31b49abd2890731828ba046'));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body)['results'];
      return jsonList.map((json) => PopularMoviesModel.fromJson(json)).toList();
    } else {
      throw response.statusCode;
    }
  }
  Future<List<PopularMoviesModel>> fetchDataFromSearch(String query)async{
    var response =await http.get(Uri.parse('https://api.themoviedb.org/3/search/movie?query=$query&api_key=769e3e5bd31b49abd2890731828ba046'));
    if(response.statusCode == 200){
      List<dynamic> json = jsonDecode(response.body)['results'];
      return json.map((json) => PopularMoviesModel.fromJson(json)).toList();
    }else{
      throw Exception();
    }
  }
}
// Future<List<CategoryNameModel>> fetchCategoryName(String api) async {
//   final response = await http.get(Uri.parse(api));
//   if (response.statusCode == 200) {
//     List<dynamic> jsonList = jsonDecode(response.body)['genres'];
//     return jsonList.map((json) => CategoryNameModel.fromJson(json)).toList();
//   } else {
//     throw Exception('Failed to load characters');
//   }
// }
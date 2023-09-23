import 'package:flutter/material.dart';
import 'package:movie/Api/popular_movies_api.dart';
import 'package:movie/Models/category_name_model.dart';
import 'package:movie/Widgets/movieContainerInSearchAndCategoryMovies.dart';
import '../Models/popular_movies_model.dart';
import '../const.dart';

class ShowMoviesWithSelectedCategory extends StatefulWidget {
  ShowMoviesWithSelectedCategory({super.key, required this.categoryNameModel});
  CategoryNameModel categoryNameModel;

  @override
  State<ShowMoviesWithSelectedCategory> createState() =>
      _ShowMoviesWithSelectedCategoryState();
}

class _ShowMoviesWithSelectedCategoryState
    extends State<ShowMoviesWithSelectedCategory> {
  late Future<List<PopularMoviesModel>> myMovies;

  @override
  void initState() {
    super.initState();
    myMovies = PopularMoviesApi()
        .fetchCategoryMovies(id: widget.categoryNameModel.categoryId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(widget.categoryNameModel.categoryName),
      ),
      backgroundColor: scaffoldBackground,
      body: FutureBuilder<List<PopularMoviesModel>>(
        future: myMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            List<PopularMoviesModel> movies = snapshot.data!;
            return ListView.separated(
              itemBuilder: (context, index) {
                return MovieContainerInSearchAndCategoryMovies(
                    popularMoviesMode: movies[index], isWatch: false,);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  height: 2,
                  indent: 20,
                  endIndent: 20,
                  thickness: 1,
                  color: Color.fromRGBO(255, 255, 255, 0.6),
                );
              },
              itemCount: movies.length,
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

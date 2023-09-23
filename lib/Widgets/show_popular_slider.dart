import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie/Widgets/popular_movie_show_items.dart';

import '../Api/popular_movies_api.dart';
import '../Models/popular_movies_model.dart';
import '../const.dart';

class PopularSlider extends StatefulWidget {
  const PopularSlider({Key? key}) : super(key: key);

  @override
  State<PopularSlider> createState() => _PopularSliderState();
}

class _PopularSliderState extends State<PopularSlider> {
  late Future<List<PopularMoviesModel>> allMovies;

  @override
  void initState() {
    super.initState();
    allMovies = PopularMoviesApi().fetchData(nowPlaying);
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PopularMoviesModel>>(
      future: allMovies,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (snapshot.hasData) {
          List<PopularMoviesModel> sliderShowMovies = snapshot.data!;
          return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 305,
              child: showPopularMoviesSlider(sliderShowMovies));
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  showPopularMoviesSlider(List<PopularMoviesModel> sliderList) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return CarouselSlider.builder(
        itemCount: sliderList.length,
        itemBuilder: (BuildContext context, int index, int pageViewIndex) =>
            PopularMovieShow(popularMoviesMode: sliderList[index]),
        options: CarouselOptions(
          autoPlay: true,
          animateToClosest: true,
          // autoPlayCurve: Curves.decelerate,
          aspectRatio: constraints.maxWidth / constraints.maxHeight,
          // height: 400,
          viewportFraction: 1.0,
          // autoPlay: true
        ),
      );
    });
  }
}

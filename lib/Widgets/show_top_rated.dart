import 'package:flutter/material.dart';
import 'package:movie/Widgets/movie_items.dart';

import '../Api/popular_movies_api.dart';
import '../Models/popular_movies_model.dart';
import '../const.dart';

class ShowTopRated extends StatefulWidget {
  const ShowTopRated({Key? key}) : super(key: key);

  @override
  State<ShowTopRated> createState() => _ShowTopRatedState();
}

class _ShowTopRatedState extends State<ShowTopRated> {
  late Future<List<PopularMoviesModel>> topRatedList;
  @override
  void initState() {
    super.initState();
    topRatedList = PopularMoviesApi().fetchData(topRated);
  }

  getData() async {}

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: const Color(0xFF282A28),
      child: FutureBuilder(
        future: PopularMoviesApi().fetchData(topRated),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          }
          if (snapshot.hasData) {
            List<PopularMoviesModel> myPopularMovies = snapshot.data!;
            return Container(
                color: const Color(0xFF282A28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'Top Rated',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: SizedBox(
                            height: 240,
                            child: ListView.separated(
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    width: 12,
                                  );
                                },
                                scrollDirection: Axis.horizontal,
                                itemCount: myPopularMovies.length,
                                itemBuilder: (context, index) {
                                  return
                                    Expanded(child:  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MovieItems(
                                          allItems: true,
                                          popularMoviesMode:
                                              myPopularMovies[index]),
                                    ],
                                  ));
                                }))),
                  ],
                ));
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

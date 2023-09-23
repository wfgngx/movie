import 'package:flutter/material.dart';
import 'package:movie/Models/popular_movies_model.dart';
import 'package:movie/Models/video_model_api.dart';
import 'package:movie/Widgets/movie_items.dart';
import 'package:movie/const.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../Api/popular_movies_api.dart';

class MovieDetailsScreen extends StatefulWidget {
  final PopularMoviesModel popularMoviesMode;
  const MovieDetailsScreen({super.key, required this.popularMoviesMode});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late Future<List<PopularMoviesModel>> similarList;
  // late Future<List<VideoModelApi>> myVideo
  // void getSimilar() async {
  //   similarList =
  //        PopularMoviesApi().fetchSimilar(widget.popularMoviesMode.id);
  // }

  @override
  void initState() {
    super.initState();
    similarList = PopularMoviesApi().fetchSimilar(widget.popularMoviesMode.id);
  }

  @override
  Widget build(BuildContext context) {
    Map idMeaning = {
      28: 'Action',
      12: 'Adventure',
      16: 'Animation',
      35: 'Comedy',
      80: 'Crime',
      99: 'Documentary',
      18: 'Drama',
      10751: 'Family',
      14: 'Fantasy',
      36: 'History',
      27: 'Horror',
      10402: 'Music',
      9648: 'Mystery',
      10749: 'Romance',
      878: 'Science Fiction',
      10770: 'TV Movie',
      53: 'Thriller',
      10752: 'War',
      37: 'Western',
    };
    return Scaffold(
        backgroundColor: scaffoldBackground,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: scaffoldBackground,
          title: Text(
            widget.popularMoviesMode.title,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                Image.network(
                  "https://image.tmdb.org/t/p/w500${widget.popularMoviesMode.backdrop_path}",
                  width: double.infinity,
                  fit: BoxFit.cover,
                  height: 200,
                ),
                Positioned(
                    top: 50,
                    bottom: 50,
                    right: 100,
                    left: 100,
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.play_circle,
                          color: Colors.white,
                          size: 50,
                        ))),
              ]),
              const SizedBox(
                height: 8,
              ),
              Text(
                widget.popularMoviesMode.title!,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                widget.popularMoviesMode.release_date!,
                style: const TextStyle(color: Color(0xFFB5B4B4), fontSize: 10),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      MovieItems(
                        popularMoviesMode: widget.popularMoviesMode,
                        allItems: false,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          // const Icon(Icons.no_adult_content,color: Colors.yellow,size: 30,),
                          const Text(
                            'Adult : ',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            widget.popularMoviesMode.adult == false
                                ? 'No'
                                : 'Yes',
                            style: const TextStyle(color: Colors.white),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  SizedBox(
                      width: 194,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemCount:
                                // #B5B4B4
                                widget.popularMoviesMode.genre_ids!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                // height: 50,
                                // decoration: BoxDecoration(
                                //   border: const Border.fromBorderSide(BorderSide(color: Colors.white)),
                                //   borderRadius: BorderRadius.circular(8),
                                // ),
                                margin: const EdgeInsets.all(8),
                                // color: Colors.blue,

                                child: Text(
                                  idMeaning[widget
                                      .popularMoviesMode.genre_ids![index]],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              );
                            },
                          ),
                          Text(
                            widget.popularMoviesMode.overview!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Color(0xFFF7B539),
                                size: 30,
                              ),
                              Text(
                                widget.popularMoviesMode.vote_average!
                                    .toStringAsFixed(1),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ))
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Container(
                height: 300,
                color: const Color(0xFF282A28),
                child: FutureBuilder<List<PopularMoviesModel>>(
                  future: similarList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text("Something went wrong"),
                      );
                    } else if (snapshot.hasData) {
                      List<PopularMoviesModel> similarList = snapshot.data!;
                      return Container(
                          color: const Color(0xFF282A28),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(12),
                                child: Text(
                                  'More Like This',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: SizedBox(
                                      height: 240,
                                      child: ListView.separated(
                                          separatorBuilder: (context, index) {
                                            return const SizedBox(
                                              width: 12,
                                            );
                                          },
                                          scrollDirection: Axis.horizontal,
                                          itemCount: similarList.length,
                                          itemBuilder: (context, index) {
                                            return MovieItems(
                                                allItems: true,
                                                popularMoviesMode:
                                                    similarList[index]);
                                          }))),
                            ],
                          ));
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              )
            ],
          )),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:movie/Models/popular_movies_model.dart';
import 'package:movie/Screens/movie_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../Provider/FireBase/firebase_function.dart';

class MovieItems extends StatefulWidget {
  bool marked = false;
  MovieItems(
      {super.key, required this.popularMoviesMode, required this.allItems});
  final PopularMoviesModel popularMoviesMode;
  bool allItems;

  @override
  State<MovieItems> createState() => _MovieItemsState();
}

class _MovieItemsState extends State<MovieItems> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      widget.marked = widget.popularMoviesMode.isMarked;
    });
    var providerWatchList = Provider.of<FirebaseFunctions>(context).myWatchList;
    return Card(
      elevation: 5,
      color: const Color(0xFF343534),
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MovieDetailsScreen(
                          popularMoviesMode: widget.popularMoviesMode,
                        )));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: CachedNetworkImage(
                        width: 130,
                        height: 160,
                        fit: BoxFit.cover,
                        imageUrl:
                            "https://image.tmdb.org/t/p/w500${widget.popularMoviesMode.poster_path}",
                        placeholder: (context, url) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return const Icon(Icons.error);
                        },
                      )),
                  Positioned(
                      child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(8)),
                    child: InkWell(
                      onTap: () async {
                        if (providerWatchList.any((element) =>
                            element.id == widget.popularMoviesMode.id)) {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  content: Text(
                            "Movie already saved",
                            style: TextStyle(
                              color: Color(0xFFF7B539),
                            ),
                          )));
                        } else {
                          setState(() {
                            widget.popularMoviesMode.isMarked = true;
                            providerWatchList.add(widget.popularMoviesMode);
                            FirebaseFunctions.addMovie(
                                widget.popularMoviesMode);
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    content: Text(
                              "Movie Saved in watchList",
                              style: TextStyle(
                                color: Color(0xFFF7B539),
                              ),
                            )));
                          });
                        }
                        // PopularMoviesModel movie = PopularMoviesModel(
                        //     title: widget.popularMoviesMode.title,
                        //     id: widget.popularMoviesMode.id,
                        //     adult: widget.popularMoviesMode.adult,
                        //     backdrop_path: widget.popularMoviesMode.backdrop_path,
                        //     genre_ids: widget.popularMoviesMode.genre_ids,
                        //     overview: widget.popularMoviesMode.overview,
                        //     popularity: widget.popularMoviesMode.popularity,
                        //     poster_path: widget.popularMoviesMode.poster_path,
                        //     release_date: widget.popularMoviesMode.release_date,
                        //     vote_average: widget.popularMoviesMode.vote_average,
                        //     vote_count: widget.popularMoviesMode.vote_count,
                        //     idFirebase: 'test');
                      },
                      child: CustomPaint(
                        painter: Chevron(
                            popularMoviesModel: widget.popularMoviesMode,
                            watchList: providerWatchList),
                        child: SizedBox(
                          width: 40.0,
                          height: 50.0,
                          child: Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 0, bottom: 0, top: 7),
                                  child: Icon(
                                    providerWatchList.any((element) =>
                                            element.id ==
                                            widget.popularMoviesMode.id)
                                        ? Icons.done
                                        : Icons.add,
                                    color: Colors.white,
                                  ))),
                        ),
                      ),
                    ),
                  )),
                ],
              ),
              if (widget.allItems == true)
                SizedBox(
                    width: 124,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.star,
                                size: 18,
                                color: Color(0xFFF7B539),
                              ),
                              Text(
                                widget.popularMoviesMode.vote_average
                                    .toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                widget.popularMoviesMode.title.length > 12
                                    ? widget.popularMoviesMode.title
                                        .substring(0, 13)
                                    : widget.popularMoviesMode.title
                                        .substring(0, 5),
                                style: const TextStyle(color: Colors.white),
                              ),
                              widget.popularMoviesMode.title.length > 10
                                  ? const Text(
                                      '...',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  : const Text('')
                            ],
                          ),
                          Text(
                            widget.popularMoviesMode.release_date
                                .substring(0, 4),
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 12),
                          ),
                          const SizedBox(
                            height: 4,
                          )
                        ],
                      ),
                    ))
            ],
          )),
    );
  }

  check(PopularMoviesModel popularMoviesModel) {
    if (popularMoviesModel.isMarked == false) {
      popularMoviesModel.isMarked = true;
    }
  }
}

class Chevron extends CustomPainter {
  const Chevron(
      {super.repaint,
      required this.popularMoviesModel,
      required this.watchList});
  final PopularMoviesModel popularMoviesModel;
  final List<PopularMoviesModel> watchList;
  @override
  void paint(Canvas canvas, Size size) {
    Gradient gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: watchList.any((element) => element.id == popularMoviesModel.id)
          // watchList.contains(popularMoviesModel)
          ? [const Color(0xFFF7B539), const Color(0xFFF7B539)]
          : [
              const Color.fromRGBO(81, 79, 79, 0.8),
              const Color.fromRGBO(81, 79, 79, 0.8),
            ],
      tileMode: TileMode.clamp,
    );
    final Rect colorBounds = Rect.fromLTRB(0, 0, size.width, size.height);
    final Paint paint = Paint()..shader = gradient.createShader(colorBounds);

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width / 2, size.height - size.height / 3);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
// List<PopularMoviesModel> updatedWatchList =
//  List.from(providerWatchList);
// updatedWatchList.add(movie);
// Provider.of<FirebaseFunctions>(context, listen: false)
//     .updateWatchList(updatedWatchList);

//     .then((value) {
//   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//       duration: Duration(milliseconds: 800),
//       content: Text("Movie added")));
//   // List<PopularMoviesModel> updatedWatchList =
//   //     List.from(providerWatchList);
//   // updatedWatchList.add(movie);
//   // Provider.of<FirebaseFunctions>(context, listen: false)
//   //     .updateWatchList(updatedWatchList);
// });
// colors: popularMoviesModel.idFirebase == null

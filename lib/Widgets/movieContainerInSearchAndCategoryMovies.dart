import 'package:flutter/material.dart';
import 'package:movie/Models/popular_movies_model.dart';
import 'package:movie/Widgets/movie_items.dart';

class MovieContainerInSearchAndCategoryMovies extends StatelessWidget {
  MovieContainerInSearchAndCategoryMovies(
      {super.key, required this.popularMoviesMode, required this.isWatch});
  PopularMoviesModel popularMoviesMode;
  bool isWatch;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            MovieItems(
              popularMoviesMode: popularMoviesMode,
              allItems: false,
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  popularMoviesMode.title!,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  popularMoviesMode.overview,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(popularMoviesMode.release_date,
                    style: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.6),
                        fontSize: 13,
                        fontWeight: FontWeight.w400)),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Color(0xFFF7B539),
                    ),
                    Text(
                      popularMoviesMode.vote_average!.toStringAsFixed(1),
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),

                // Text(popularMoviesMode.adult.toString(),
                //     overflow: TextOverflow.ellipsis,
                //     style: const TextStyle(
                //         color: Color.fromRGBO(255, 255, 255, 0.6),
                //         fontSize: 13,
                //         fontWeight: FontWeight.w400))
              ],
            ))
          ],
        ),
      ),
    );
  }
}

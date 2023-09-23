import 'package:flutter/material.dart';
import 'package:movie/Models/popular_movies_model.dart';
import 'package:movie/Widgets/movie_items.dart';
import 'package:transparent_image/transparent_image.dart';

class PopularMovieShow extends StatelessWidget {
  const PopularMovieShow({super.key, required this.popularMoviesMode});
  final PopularMoviesModel popularMoviesMode;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 300,
        child: Stack(
          children: [
            FadeInImage(
                width: double.infinity,
                height: 250,
                fit: BoxFit.contain,
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(
                    "https://image.tmdb.org/t/p/w500${popularMoviesMode.backdrop_path}")),
            Positioned(
              top: 95,
              left: 150,
              child: IconButton(
                iconSize: 60,
                onPressed: () {},
                icon: const Icon(
                  Icons.play_circle,
                ),
                color: Colors.white,
              ),
            ),
            Positioned(
                // height: 300,
                top: 125,
                left: 15,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    MovieItems(
                      popularMoviesMode: popularMoviesMode,
                      allItems: false,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              popularMoviesMode.title,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              popularMoviesMode.release_date,
                              style: const TextStyle(
                                  fontSize: 10, color: Color(0xFFB5B4B4)),
                            )
                          ],
                        ))
                  ],
                ))
          ],
        ));
  }
}

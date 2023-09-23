import 'package:flutter/material.dart';
import 'package:movie/Api/popular_movies_api.dart';
import 'package:movie/Widgets/movieContainerInSearchAndCategoryMovies.dart';
import 'package:movie/const.dart';

import '../../Models/popular_movies_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchText = TextEditingController();

  late Future<List<PopularMoviesModel>> searchMovies;
  @override
  void initState() {
    super.initState();
    searchMovies = PopularMoviesApi().fetchDataFromSearch(searchText.text);
  }

  @override
  Widget build(BuildContext context) {
    searchMovies = PopularMoviesApi().fetchDataFromSearch(searchText.text);

    return Scaffold(
        backgroundColor: scaffoldBackground,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 18, right: 18),
              child: TextField(
                  style: const TextStyle(color: Colors.white),
                  onSubmitted: (value) {
                    setState(() {
                      searchText.text = value;
                    });
                  },
                  controller: searchText,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(onPressed: (){
                     setState(() {
                       searchText.clear();
                     });
                    }, icon:const  Icon(Icons.cancel,color: Colors.white,)),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      hintText: 'Search',
                      hintStyle: const TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: const Color(0xFF514F4F),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(18)))),
            ),
            searchText.text.isEmpty
                ? const Expanded(
                    child: Center(
                        child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text(
                      //   'Search About Movies',
                      //   style: TextStyle(color: Colors.white, fontSize: 18),
                      // ),
                      Icon(
                        Icons.movie,
                        color: Colors.white,
                        size: 150,
                      ),
                    ],
                  )))
                : Expanded(
                    child: FutureBuilder<List<PopularMoviesModel>>(
                    future: searchMovies,
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
                        List<PopularMoviesModel> myResults = snapshot.data!;
                        return  ListView.separated(
                          itemCount: myResults.length,
                          separatorBuilder: (context, index) {
                            return const Divider(
                              height: 5,
                            );
                          },
                          itemBuilder: (context, index) {
                            return MovieContainerInSearchAndCategoryMovies(
                              isWatch: false,
                                popularMoviesMode: myResults[index]);
                          },
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ))
          ],
        ));
  }
}

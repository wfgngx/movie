import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/FireBase/firebase_function.dart';
import '../../Widgets/movieContainerInSearchAndCategoryMovies.dart';
import '../../const.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({Key? key}) : super(key: key);

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Watch List",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: scaffoldBackground,
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
            stream: FirebaseFunctions().getTasks(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Some Thing Went Wrong"),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasData) {
                var provider = Provider.of<FirebaseFunctions>(context);
                provider.myWatchList =
                    snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
                return ListView.separated(
                    itemCount: provider.myWatchList.length,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 5,
                        indent: 20,
                        endIndent: 20,
                      );
                    },
                    itemBuilder: (context, index) {
                      return SizedBox(width: 300,child:  Row(
                        children: [
                          MovieContainerInSearchAndCategoryMovies(
                              isWatch: true,
                              popularMoviesMode: provider.myWatchList[index]),
                          IconButton(
                              onPressed: () {
                                FirebaseFunctions.deleteTask(
                                    provider.myWatchList[index].idFirebase!);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Color(0xFFF7B539),
                              ))
                        ],
                      ));

                      // InkWell(
                      //
                      //   onLongPress: () {
                      //     FirebaseFunctions.deleteTask(
                      //         provider.myWatchList[index].idFirebase!);
                      //   },
                      //   child:
                    });
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ))
        ],
      ),
    );
  }
}

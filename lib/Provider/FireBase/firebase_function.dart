import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie/Models/popular_movies_model.dart';

class FirebaseFunctions extends ChangeNotifier {
  List<PopularMoviesModel> myWatchList = [];

  // void updateWatchList(List<PopularMoviesModel> newWatchList) {
  //   myWatchList = newWatchList;
  //   notifyListeners();
  // }
  static CollectionReference<PopularMoviesModel> getMovies() {
    return FirebaseFirestore.instance
        .collection('Movies')
        .withConverter<PopularMoviesModel>(
      fromFirestore: (snapshot, _) {
        final data = snapshot.data()!;
        return PopularMoviesModel.fromJson(data)..idFirebase = snapshot.id;
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  }

  static Future<void> addMovie(PopularMoviesModel popularMoviesModel) {
    var collection = getMovies();
    var doc = collection.doc();
    popularMoviesModel.idFirebase = doc.id;
    return doc.set(popularMoviesModel);
  }

  Stream<QuerySnapshot<PopularMoviesModel>> getTasks() {
    return getMovies()
        // .where("date",
        //     isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(String id) {
    return getMovies().doc(id).delete();
  }

  static Future<void> updateTask(String id, PopularMoviesModel task) async {
    return getMovies().doc(id).set(task);
  }
}

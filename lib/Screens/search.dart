import 'package:flutter/material.dart';
import 'package:movie/const.dart';
class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: scaffoldBackground,
      body: Center(child: Text("Search"),),);
  }
}

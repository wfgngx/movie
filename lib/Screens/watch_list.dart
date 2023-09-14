import 'package:flutter/material.dart';

import '../const.dart';
class WatchListScreen extends StatelessWidget {
  const WatchListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: scaffoldBackground,

      body: Center(child: Text("WatchList"),),);
  }
}

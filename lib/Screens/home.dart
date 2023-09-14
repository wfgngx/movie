import 'package:flutter/material.dart';

import '../const.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: scaffoldBackground,

      body: Center(child: Text("Home"),),);
  }
}

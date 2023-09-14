import 'package:flutter/material.dart';

import '../const.dart';
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: scaffoldBackground,

      body: Center(child: Text("Categories"),),);

  }
}

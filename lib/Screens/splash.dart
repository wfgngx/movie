import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie/Screens/bottom_nav_bar.dart';
import 'package:movie/const.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showNavScreen();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackground,
      body: Center(
      child: Image.asset("assets/images/movies.png"),

    ),);
  }
  void showNavScreen(){
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavBaScreen()));
    });
  }
}

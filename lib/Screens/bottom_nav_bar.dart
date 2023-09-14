import 'package:flutter/material.dart';
import 'package:movie/Screens/categories.dart';
import 'package:movie/Screens/home.dart';
import 'package:movie/Screens/search.dart';
import 'package:movie/Screens/watch_list.dart';
import 'package:movie/const.dart';

class BottomNavBaScreen extends StatefulWidget {
  const BottomNavBaScreen({super.key});

  @override
  State<BottomNavBaScreen> createState() => _BottomNavBaScreenState();
}

class _BottomNavBaScreenState extends State<BottomNavBaScreen> {
  List<Widget> screensNav = const [
    HomeScreen(),
    SearchScreen(),
    CategoriesScreen(),
    WatchListScreen()
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: const Color(0xFF1A1A1A)),
        child: BottomNavigationBar(
            elevation: 5,
            showUnselectedLabels: true,
            unselectedItemColor: unSelectedIcon,
            selectedItemColor: primaryColor,
            currentIndex: index,
            onTap: (value) {
              setState(() {
                index = value;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  // color: primaryColor,
                ),
                label: 'HOME',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    // color: primaryColor,
                  ),
                  label: 'SEARCH'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.movie,
                    // color: primaryColor,
                  ),
                  label: 'BROWSE'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.bookmarks_rounded,
                    // color: primaryColor,
                  ),
                  label: 'WATCHLIST'),
            ]),
      ),
      body: screensNav[index],
    );
  }
}

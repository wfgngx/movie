import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie/Screens/show_movies_with_selectedCategory.dart';
import 'package:movie/const.dart';
import 'dart:convert';

import '../../Models/category_name_model.dart';

class PopularMoviesApi {
  Future<List<CategoryNameModel>> fetchCategoryName(String api) async {
    final response = await http.get(Uri.parse(api));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body)['genres'];
      return jsonList.map((json) => CategoryNameModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late Future<List<CategoryNameModel>> categories;

  @override
  void initState() {
    super.initState();
    categories = PopularMoviesApi().fetchCategoryName(categoryName);
  }

  // void getCategory() async {
  //   categories = await PopularMoviesApi().fetchCategoryName(categoryName);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Browse Category"),),
        backgroundColor: scaffoldBackground,
        body: FutureBuilder<List<CategoryNameModel>>(
          future: categories,
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
              List<CategoryNameModel> cat = snapshot.data!;
              return GridView.builder(
                itemCount: cat.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(8),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return ShowMoviesWithSelectedCategory(
                                    categoryNameModel: cat[index]);
                              },
                            ));
                          },
                          child:
                          Stack(
                            children: [
                              Image.asset('assets/images/category.png',height:170,fit: BoxFit.contain,),
                              // FadeInImage(placeholder: MemoryImage(kTransparentImage), image: const AssetImage('assets/images/category.png')),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child:Container(decoration: const BoxDecoration(color: Colors.black12),child:  Text(cat[index].categoryName,style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w400),),))
                            ],
                          ),
                          // Container(
                          //   color: unSelectedIcon,
                          //   child: Center(
                          //     child: Text(cat[index].categoryName),
                          //   ),
                          // )
                      ));
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
// import 'package:flutter/material.dart';
// import 'package:movie/Models/category_name_model.dart';
//
// import '../Api/popular_movies_api.dart';
// import '../const.dart';
//
// class CategoriesScreen extends StatefulWidget {
//    const CategoriesScreen({Key? key, }) : super(key: key);
//
//   @override
//   State<CategoriesScreen> createState() => _CategoriesScreenState();
// }
//
// class _CategoriesScreenState extends State<CategoriesScreen> {
//   late Future<List<CategoryNameModel>> categories;
//
//
//   @override
//   void initState() {
//     super.initState();
//     categories = PopularMoviesApi().fetchCategoryName(categoryName);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return
//       FutureBuilder(
//         future: categories,
//         builder: (context, snapshot) {
//           if (snapshot.hasData &&
//               snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return  Center(
//               child: Text(snapshot.error.toString()),
//             );
//           } else if (snapshot.hasData) {
//             List<CategoryNameModel> cat = snapshot.data!;
//             return   GridView.builder(
//               itemCount: cat.length,
//               gridDelegate:
//               const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//               itemBuilder: (context, index) {
//               return  Container(color: Colors.blue,child: Text(cat[index].categoryName),);
//
//               },
//             )
//             ;
//               // Container(
//               //   color: const Color(0xFF282A28),
//               //   child: Column(
//               //     crossAxisAlignment: CrossAxisAlignment.start,
//               //     children: [
//               //       const Padding(
//               //         padding: EdgeInsets.all(12),
//               //         child: Text(
//               //           'More Like This',
//               //           style: TextStyle(
//               //               fontSize: 15,
//               //               fontWeight: FontWeight.bold,
//               //               color: Colors.white),
//               //         ),
//               //       ),
//               //       Padding(
//               //           padding:
//               //           const EdgeInsets.only(left: 8, right: 8),
//               //           child: SizedBox(
//               //               height: 160,
//               //               child: ListView.separated(
//               //                   separatorBuilder: (context, index) {
//               //                     return const SizedBox(
//               //                       width: 12,
//               //                     );
//               //                   },
//               //                   scrollDirection: Axis.horizontal,
//               //                   itemCount: similarList.length,
//               //                   itemBuilder: (context, index) {
//               //                     return MovieItems(
//               //                         popularMoviesMode:
//               //                         similarList[index]);
//               //                   }))),
//               //     ],
//               //   ));
//           }
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       );
//
//     }
//
//   }
//

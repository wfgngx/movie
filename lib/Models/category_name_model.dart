// class CategoryNameModel {
//   String categoryName;
//   int categoryId;
//   CategoryNameModel({required this.categoryName, required this.categoryId});
//   factory CategoryNameModel.fromJson(Map<String, dynamic> data) {
//     return CategoryNameModel(
//         categoryName: data['name'], categoryId: data['id']);
//   }
// }
class CategoryNameModel {
  String categoryName;
  int categoryId;

  CategoryNameModel({required this.categoryName, required this.categoryId});

  factory CategoryNameModel.fromJson(Map<String, dynamic> data) {
    return CategoryNameModel(
      categoryName: data['name'],
      categoryId: data['id'],
    );
  }
}
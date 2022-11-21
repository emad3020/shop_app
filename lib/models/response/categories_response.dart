class CategoriesResponse {
  bool? status;
  String? message;
  CategoriesData? data;
  CategoriesResponse.fromJson(Map<String, dynamic>? json) {
    status = json?['status'];
    message = json?['message'];
    data = CategoriesData.fromJson(json?['data']);
  }
}

class CategoriesData {
  int? currentPage;
  List<CategoryModel> categoriesList = [];

  CategoriesData.fromJson(Map<String, dynamic>? json) {
    json?['data']?.forEach((category) {
      categoriesList.add(CategoryModel.fromJson(category));
    });
  }
}

class CategoryModel {
  int? id;
  String? name;
  String? categoryImage;

  CategoryModel.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    name = json?['name'];
    categoryImage = json?['image'];
  }
}

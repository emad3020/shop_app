import 'dart:ffi';

class HomeResponse {
  bool? status;
  HomeDataModel? data;

  HomeResponse.fromJson(Map<String, dynamic>? json) {
    status = json?['status'];
    data = HomeDataModel.fromJson(json?['data']);
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];
  HomeDataModel.fromJson(Map<String, dynamic>? json) {
    json?['banners']?.forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });

    json?['products']?.forEach((element) {
      products.add(ProductModel.fromJson(element));
    });
  }
}

class BannerModel {
  int? id;
  String? image;
  BannerModel.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    image = json?['image'];
  }
}

class ProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  bool? isFavorite;
  bool? isAddedToCart;

  ProductModel.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    price = json?['price'];
    oldPrice = json?['old_price'];
    discount = json?['discount'];
    image = json?['image'];
    name = json?['name'];
    description = json?['description'];
    isFavorite = json?['in_favorites'];
    isAddedToCart = json?['in_cart'];
  }
}

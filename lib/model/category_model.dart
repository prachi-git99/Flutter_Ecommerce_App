// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

// String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    required this.categories,
  });

  List<Category> categories;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );

  // Map<String, dynamic> toJson() => {
  //   "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
  // };
}

class Category {
  Category({
    required this.name,
    required this.subcategory,
  });

  String name;
  List<String> subcategory;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    name: json["name"],
    subcategory: List<String>.from(json["subcategory"].map((x) => x)),
  );

  // Map<String, dynamic> toJson() => {
  //   "name": name,
  //   "subcategory": List<dynamic>.from(subcategory.map((x) => x)),
  // };
}

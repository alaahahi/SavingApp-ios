import 'package:coupons/models/helper.dart';

class CategoryModel {
  CategoryModel({
    this.title,
    this.photo,
    this.logo,
    this.order,
    this.category,
    this.id,
  });

  final String title;
  final String photo;
  final String logo;
  final int order;
  final String category;

  final int id;

  factory CategoryModel.fromJson(dynamic json) {
    return CategoryModel(
      id: int.parse((json['categoryId'] ?? json['id']).toString()),
      title: json['title'],
      photo: fixPhotoUrl(url: json['photo']),
      logo: fixPhotoUrl(url: json['logo']),
      order: int.parse(json['order'].toString()),
      category: json['category'],
    );
  }
}

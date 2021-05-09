import 'helper.dart';

class ProductModel {
  ProductModel({
    this.id,
    this.photo,
    this.price,
    this.title,
    this.desc,
    this.discountPrice,
    // this.discount_start_data,
    // this.discount_end_data,
    this.companyId,
  });

  final int id;
  final int companyId;
  final String photo;
  final String title;
  final String desc;
  final int price;
  final int discountPrice;
  // final String discount_start_data;
  // final String discount_end_data;

  factory ProductModel.fromJson(dynamic json) {
    return ProductModel(
      id: int.parse((json['productId'] ?? json['id']).toString()),
      photo: fixPhotoUrl(url: json['photo']),
      title: json['title'] ?? '',
      desc: json['desc'] ?? '',
      price: double.parse(json['price']?.toString() ?? '0.0').round(),
      discountPrice:
          double.parse(json['discount_price']?.toString() ?? '0.0').round(),
      // // discount_start_data: json['discount_start_data'],
      // // discount_end_data: json['discount_end_data'],
      companyId: int.parse(json['companyId'].toString()),
    );
  }
}

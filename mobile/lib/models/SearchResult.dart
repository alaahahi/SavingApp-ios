import 'package:coupons/models/CompanyModel.dart';
import 'package:coupons/models/ProductModel.dart';

class SearchResult {
  SearchResult({
    this.products,
    this.companies,
  });

  final List<CompanyModel> companies;
  final List<ProductModel> products;

  factory SearchResult.fromJson(dynamic json) {
    return SearchResult(
      products: (json['products'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList(),
      companies: (json['companies'] as List)
          .map((e) => CompanyModel.fromJson(e))
          .toList(),
    );
  }
}

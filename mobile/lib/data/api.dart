import 'package:coupons/data/fetcher.dart';
import 'package:coupons/models/CategoriesModel.dart';
import 'package:coupons/models/CompanyModel.dart';
import 'package:coupons/models/ProductModel.dart';
import 'package:coupons/models/OrderModel.dart';
import 'package:coupons/models/SearchResult.dart';
import 'package:coupons/models/GiftModel.dart';
import 'package:coupons/models/AdminCompany.dart';
import 'package:coupons/services/CartItem.dart';
import 'package:coupons/models/ActivationResult.dart';
import 'package:coupons/models/WeeklyAndMonthlyPullModel.dart';

import 'package:coupons/models/UserInfoModel.dart';

class Api extends Fetcher {
  Api({this.baseUrl, this.langFunc});

  String baseUrl;
  String Function() langFunc;

  String get lang => (langFunc() == 'fa' ? 'ku' : langFunc()) ?? 'en';

  Future<List<CategoryModel>> getCategories() async {
    return await getParsedList(
      '$baseUrl/categories/$lang',
      (data) => CategoryModel.fromJson(data),
    );
  }

  Future<List<CompanyModel>> getCompanies({int categoryId}) async {
    return await getParsedList(
      '$baseUrl/categories/$categoryId/companies/$lang',
      (data) => CompanyModel.fromJson(data),
    );
  }

  Future<List<ProductModel>> getProducts({int comapnyId}) async {
    return await getParsedList(
      '$baseUrl/companies/$comapnyId/products/$lang',
      (data) => ProductModel.fromJson(data),
    );
  }

  Future<List<WeeklyAndMonthlyPullModel>> getWeeklyAndMonthlyPull() async {
    return await getParsedList(
      '$baseUrl/winner/$lang',
      (data) => WeeklyAndMonthlyPullModel.fromJson(data),
    );
  }

  Future<String> activation({String phone, String card}) async {
    return await getParsed<String>('$baseUrl/charge_card/$card/$phone', (data) {
      final isData = RegExp(
        r'^([0-9]{4}|[0-9]{2})[-]([0]?[1-9]|[1][0-2])[-]([0]?[1-9]|[1|2][0-9]|[3][0|1])$',
        multiLine: false,
      );

      if (isData.hasMatch(data.toString()) ||
          data.toString().trim().replaceAll('"', '').startsWith("310")) {
        return data.toString();
      }
      throw Exception(data.toString());
    });
  }

  Future<ActivationResult> checkActivation({String phone}) async {
    return await getParsed<ActivationResult>(
      '$baseUrl/check_card/$phone',
      (data) => data == false
          ? ActivationResult(active: false)
          : ActivationResult(
              active: true,
              from: data[0].toString(),
              until: data[1].toString(),
            ),
    );
  }

  Future<List<ProductModel>> getProductByIds({List<int> ids}) async {
    return await getParsedList(
      '$baseUrl/products/${ids.join(",")}/$lang',
      (data) => ProductModel.fromJson(data),
    );
  }

  Future<List<CompanyModel>> getCompaniesByIds({List<int> ids}) async {
    return await getParsedList(
      '$baseUrl/companies/${ids.join(",")}/$lang',
      (data) => CompanyModel.fromJson(data),
    );
  }

  Future<SearchResult> search({String query}) async {
    return await getParsed(
      '$baseUrl/search/$query/$lang',
      (data) => SearchResult.fromJson(data),
    );
  }

  Future<SearchResult> getHome() async {
    return await getParsed(
      '$baseUrl/home/$lang',
      (data) => SearchResult.fromJson(data),
    );
  }

  Future<int> userPoints({String phone}) async {
    return await getParsed(
      '$baseUrl/user_point/$phone',
      (data) => int.tryParse(data.toString().trim().replaceAll('"', '')) ?? 0,
    );
  }

  Future<String> submitOrder({List<CartItem> items, String phone}) async {
    final res = await post(
      '$baseUrl/orders/$phone',
      body: {
        'data': items
            .map((e) => ({
                  'productId': e.id,
                  'quantity': e.quantity,
                }))
            .toList()
      },
    );
    return res;
  }

  Future<List<OrderModel>> getOrders({String phone}) async {
    return await getParsedList(
      '$baseUrl/getorders/$phone/$lang',
      (data) => OrderModel.fromJson(data),
    );
  }

  Future<List<AdminCompanyModel>> getUserCompany({String phone}) async {
    return await getParsedList(
      '$baseUrl/getusercompany/$phone',
      (data) => AdminCompanyModel.fromJson(data),
    );
  }

  Future<List<GiftModel>> getGift() async {
    return await getParsedList(
      '$baseUrl/gift/$lang',
      (data) => GiftModel.fromJson(data),
    );
  }

  Future<UserInfoModel> getUserInfo({String Number}) async {
    return await getParsed(
      '$baseUrl/user_info/$Number',
      (data) => UserInfoModel.fromJson(data),
    );
  }

  Future<void> submitProduct({Map<String, dynamic> json, String phone}) async {
    await post('$baseUrl/productcompany/$phone', body: json);
  }

  Future<String> editUserInfo({String name, String phone}) async {
      return  await post(
      '$baseUrl/edit_user_info/$phone',
      body: {'name': name},
    );
  }
}

import 'package:coupons/models/CompanyModel.dart';
import 'package:coupons/models/helper.dart';

class AdminCompanyModel {
  AdminCompanyModel({
    this.title,
    this.photo,
    this.logo,
    this.companyId,
    this.role,
  });

  final String title;
  final String photo;
  final String logo;
  final int companyId;
  final String role;

  factory AdminCompanyModel.fromJson(dynamic json) {
    return AdminCompanyModel(
      title: json['title'],
      photo: fixPhotoUrl(url: json['photo']),
      logo: fixPhotoUrl(url: json['logo']),
      companyId: json['companyId'],
      role: json['role'],
    );
  }

  CompanyModel toComapnyModel() {
    return CompanyModel(
      title: title,
      phone: photo,
      logo: logo,
      id: companyId,
    );
  }
}

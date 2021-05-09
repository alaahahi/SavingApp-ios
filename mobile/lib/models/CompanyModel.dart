import 'package:map_launcher/map_launcher.dart';

import 'helper.dart';

class CompanyModel {
  CompanyModel({
    this.id,
    this.title,
    this.photo,
    this.statues,
    this.category,
    this.desc,
    this.logo,
    // this.distance,
    this.location,
    this.openMins,
    this.closeMins,
    this.phone,
  });
  final int id;
  final String title;
  final String photo;
  final String desc;
  final String logo;
  final String category;
  final String statues;
  // final double distance;
  final String phone;

  final Coords location;
  final int openMins;
  final int closeMins;

  factory CompanyModel.fromJson(dynamic json) {
    return CompanyModel(
      id: int.parse((json['companyId'] ?? json['id']).toString()),
      title: json['title'] ?? '',
      desc: json['desc'] ?? '',
      photo: fixPhotoUrl(url: json['photo']),
      logo: fixPhotoUrl(url: json['logo']) ?? '',
      category: json['category'] ?? '',
      // categoryId: json['categoryId'] ?? '',
      location: Coords(
        double.parse(json['location_lat'].toString()),
        double.parse(json['location_lng'].toString()),
      ),
      closeMins: int.parse(json['close_minute'].toString()),
      openMins: int.parse(json['open_minute'].toString()),
      phone: json['phone'],
      //
    );
  }

  bool get isOpen {
    final now = DateTime.now();
    final open = DateTime(now.year, now.month, now.day, 0, openMins);
    final close = DateTime(now.year, now.month, now.day, 0, closeMins);

    return now.isAfter(open) && now.isBefore(close);
  }
}

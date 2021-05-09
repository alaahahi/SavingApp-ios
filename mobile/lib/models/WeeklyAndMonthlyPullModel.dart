// To parse this JSON data, do
//
//     final weeklyAndMonthlyPullModel = weeklyAndMonthlyPullModelFromJson(jsonString);

import 'dart:convert';

import 'package:coupons/models/helper.dart';

//List<WeeklyAndMonthlyPullModel> weeklyAndMonthlyPullModelFromJson(String str) =>
//    List<WeeklyAndMonthlyPullModel>.from(
//        json.decode(str).map((x) => WeeklyAndMonthlyPullModel.fromJson(x)));
//
//String weeklyAndMonthlyPullModelToJson(List<WeeklyAndMonthlyPullModel> data) =>
//    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WeeklyAndMonthlyPullModel {
  WeeklyAndMonthlyPullModel({
    this.phont,
    this.phone,
    this.title,
    this.desc,
    this.date,
    this.type,
    this.name,
  });

  final String name;
  final String phont;
  final String phone;
  final String title;
  final String desc;
  final DateTime date;
  final String type;

  factory WeeklyAndMonthlyPullModel.fromJson(dynamic json) =>
      WeeklyAndMonthlyPullModel(
        phont: fixPhotoUrl(url: json['phont']),
        phone: json["phone"],
        title: json["title"],
        desc: json["desc"],
        date: DateTime.parse(json["date"]),
        type: json["type"],
        name: json["name"],
      );

//  Map<String, dynamic> toJson() => {
//        "phont": phont,
//        "phone": phone,
//        "title": title,
//        "desc": desc,
//        "date": date.toIso8601String(),
//        "type": type,
//      };
}

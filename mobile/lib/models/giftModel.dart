import 'dart:convert';

import 'package:coupons/models/helper.dart';

//List<GiftModel> temperaturesFromJson(String str) =>
//    List<GiftModel>.from(json.decode(str).map((x) => GiftModel.fromJson(x)));
//
//String temperaturesToJson(List<GiftModel> data) =>
//    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GiftModel {
  GiftModel({
    this.id,
    this.levelPoints,
    this.phont,
    this.title,
    this.visible,
    this.createdAt,
    this.updatedAt,
    this.icon,
    this.giftTranslation,
    this.gift_type_id,
  });

  int id;
  int levelPoints;
  int gift_type_id;
  String phont;
  String title;
  dynamic visible;
  DateTime createdAt;
  DateTime updatedAt;
  String icon;
  GiftTranslation giftTranslation;

  factory GiftModel.fromJson(dynamic json) {
    return GiftModel(
      gift_type_id: json["gift_type_id"],
      id: json["id"],
      levelPoints: json["level_points"],
      phont: fixPhotoUrl(url: json['phont']),
      title: json["title"],
      visible: json["visible"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      icon: fixPhotoUrl(url: json['icon']) ?? '',
      giftTranslation: json["gift_translation"] == null
          ? null
          : GiftTranslation.fromJson(json["gift_translation"]),
    );
  }

//  *************************

  Map<String, dynamic> toJson() => {
        "id": id,
        "gift_type_id": gift_type_id,
        "level_points": levelPoints,
        "phont": phont,
        "title": title,
        "visible": visible,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "icon": icon,
        "gift_translation":
            giftTranslation == null ? null : giftTranslation.toJson(),
      };
}

//*********************************************************

class GiftTranslation {
  GiftTranslation({
    this.id,
    this.title,
    this.lang,
    this.desc,
    this.giftId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String title;
  String lang;
  String desc;
  int giftId;
  DateTime createdAt;
  DateTime updatedAt;

  factory GiftTranslation.fromJson(dynamic json) => GiftTranslation(
        id: json["id"],
        title: json["title"],
        lang: json["lang"],
        desc: json["desc"],
        giftId: json["giftId"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "lang": lang,
        "desc": desc,
        "giftId": giftId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

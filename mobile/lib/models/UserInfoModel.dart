class UserInfoModel {
  UserInfoModel({
 //   this.id,
 //   this.roleId,
    this.name,
 //   this.companyId,
 //   this.email,
// this.avatar,
//this.emailVerifiedAt,
//    this.password,
 //   this.rememberToken,
 //   this.settings,
 //   this.createdAt,
 //   this.updatedAt,
  //  this.firstName,
  //  this.lastName,
  this.phone,
  //  this.gender,
  //  this.photo,
  //  this.locationLng,
  //  this.locationLat,
  //  this.preferedCity,
 //   this.preferedLang,
  //  this.isLocked,
  //  this.phoneVerifed,
  //  this.pushNotificationToken,
  });

//  int id;
 // int roleId;
  String name;
//  int companyId;
//  String email;
//  String avatar;
//  dynamic emailVerifiedAt;
//  String password;
//  String rememberToken;
//  dynamic settings;
//  DateTime createdAt;
//  DateTime updatedAt;
//  dynamic firstName;
//  dynamic lastName;
  String phone;
//  dynamic gender;
//  dynamic photo;
//  dynamic locationLng;
// dynamic locationLat;
// dynamic preferedCity;
//  dynamic preferedLang;
//  dynamic isLocked;
//  dynamic phoneVerifed;
//  dynamic pushNotificationToken;

  factory UserInfoModel.fromJson(dynamic json) => UserInfoModel(
      //  id: json["id"],
      //  roleId: json["role_id"],
        name: json["name"],
     //   companyId: json["company_id"],
     //   email: json["email"],
      //  avatar: json["avatar"],
     //   emailVerifiedAt: json["email_verified_at"],
      //  password: json["password"],
      //  rememberToken: json["remember_token"],
      //  settings: json["settings"],
      //  createdAt: DateTime.parse(json["created_at"]),
     //   updatedAt: DateTime.parse(json["updated_at"]),
     //   firstName: json["first_name"],
      //  lastName: json["last_name"],
     phone: json["phone"],
     //   gender: json["gender"],
     //   photo: json["photo"],
      //  locationLng: json["location_lng"],
       // locationLat: json["location_lat"],
      //  preferedCity: json["prefered_city"],
      //  preferedLang: json["prefered_lang"],
      //  isLocked: json["is_locked"],
      //  phoneVerifed: json["phone_verifed"],
     //  pushNotificationToken: json["push_notification_token"],
      );

  Map<String, dynamic> toJson() => {
       // "id": id,
      //  "role_id": roleId,
        "name": name,
      //  "company_id": companyId,
      //  "email": email,
      //  "avatar": avatar,
       // "email_verified_at": emailVerifiedAt,
      // "password": password,
       // "remember_token": rememberToken,
      //  "settings": settings,
       // "created_at": createdAt.toIso8601String(),
      //  "updated_at": updatedAt.toIso8601String(),
      //  "first_name": firstName,
       // "last_name": lastName,
        "phone": phone,
      //  "gender": gender,
       // "photo": photo,
       // "location_lng": locationLng,
       // "location_lat": locationLat,
       // "prefered_city": preferedCity,
       // "prefered_lang": preferedLang,
       // "is_locked": isLocked,
       // "phone_verifed": phoneVerifed,
       // "push_notification_token": pushNotificationToken,
      };
}

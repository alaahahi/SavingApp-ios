// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_options.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter/material.dart';

// import 'package:easy_localization/easy_localization.dart';

// class Informations extends StatefulWidget {
//   @override
//   _InformationsState createState() => _InformationsState();
// }

// class _InformationsState extends State<Informations> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: ListView(
//         children: [
//           Align(
//             alignment: Alignment.center,
//             child: Image.asset(
//               'assets/images/Saving-logo.png',
//               fit: BoxFit.fill,
//               height: 200,
//             ),
//           ),
//           Align(
//             alignment: Alignment.center,
//             child: Text(
//               "kabab ahmad _ کەباب احمد ",
//               style: titleName,
//             ),
//           ),
//           SizedBox(
//             height: 10.0,
//           ),
//           SizedBox(
//             height: 20.0,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   "10_12",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   "work hours".tr(),
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ),
//             ],
//           ),
//           CarouselSlider(
//             items: [
//               Stack(
//                 children: [
//                   CachedNetworkImage(
//                     fit: BoxFit.cover,
//                     width: double.infinity,
//                     imageUrl: 'http://3.64.128.245/savingapp/home/food.png',
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Text(
//                       '1000\$',
//                       style: titleSlider,
//                     ),
//                   ),
//                 ],
//               ),
//               Stack(
//                 children: [
//                   CachedNetworkImage(
//                     fit: BoxFit.cover,
//                     width: double.infinity,
//                     imageUrl: 'http://3.64.128.245/savingapp/home/food.png',
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Text(
//                       '3000\$',
//                       style: titleSlider,
//                     ),
//                   ),
//                 ],
//               ),
//               Stack(
//                 children: [
//                   CachedNetworkImage(
//                     fit: BoxFit.cover,
//                     width: double.infinity,
//                     imageUrl: 'http://3.64.128.245/savingapp/home/food.png',
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Text(
//                       '2000\$',
//                       style: titleSlider,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//             options: CarouselOptions(
//               viewportFraction: 1.0,
//               enableInfiniteScroll: true,
//               height: 220,
//               autoPlay: true,
//               autoPlayInterval: Duration(seconds: 6),
//               autoPlayAnimationDuration: Duration(milliseconds: 600),
//               autoPlayCurve: Curves.easeOutSine,
//               // enlargeCenterPage: true,
//               scrollDirection: Axis.horizontal,
//             ),
//           ),
//           SizedBox(
//             height: 10.0,
//           ),
//           Container(
//             color: Colors.green,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     "East".tr(),
//                     style: titlesub,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     "western".tr(),
//                     style: titlesub,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(right: 80, top: 10),
//                 child: Text(
//                   "Iraqi ".tr(),
//                   style: titleName,
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             margin: EdgeInsets.all(10),
//             height: 200,
//             child: Padding(
//               padding: const EdgeInsets.only(
//                 right: 30,
//               ),
//               child: Align(
//                 alignment: Alignment.topRight,
//                 child: Text(
//                   "Description of the place".tr(),
//                   style: TextStyle(color: Colors.white, fontSize: 30),
//                 ),
//               ),
//             ),
//             color: Color(0xFF757575),
//           ),
//           cardShow(Icons.location_on, "The site is on google".tr(),
//               "Available".tr()),
//           cardShow(Icons.time_to_leave, "parking".tr(), "Available".tr()),
//           cardShow(
//               Icons.local_shipping, "Delivery Service".tr(), "Available".tr()),
//           cardShow(Icons.stars, "Private places VIP".tr(), "Available".tr()),
//           cardShow(Icons.cake, "Meeting or event rooms".tr(), "Available".tr()),
//           cardShow(
//               Icons.music_note, "Concerts and singing".tr(), "Available".tr()),
//           cardShow(
//               Icons.favorite, "Hours of live music".tr(), "Available".tr()),
//           cardShow(Icons.accessible, "Suitable for wheelchair users".tr(),
//               "Yeah".tr()),
//           cardShow(Icons.pets, "Are pets allowed ?".tr(), "Yeah".tr()),
//           cardShow(Icons.lens, "Transfer matches and leagues".tr(),
//               "Available".tr()),
//           cardShow(Icons.smoke_free, "Special places for non-smokers".tr(),
//               "Available".tr()),
//           cardShow(Icons.smoking_rooms, "Hookah".tr(), "Available".tr()),
//           cardShow(Icons.signal_wifi_4_bar, "WIFI".tr(), "Available".tr()),
//           cardShow(Icons.spellcheck, "Do you require prior reservation".tr(),
//               "Available".tr()),
//           cardShow(
//               Icons.android,
//               "Is there a special place for children’s games".tr(),
//               "Available".tr()),
//           cardShow(Icons.polymer, "Is there an outdoor garden - terrace -".tr(),
//               "Available".tr()),
//           cardShow(Icons.child_friendly, "Baby cleaning places".tr(),
//               "Available".tr()),
//           SizedBox(
//             height: 20.0,
//           ),
//           Center(
//             child: Text(
//               "Connect with us".tr(),
//               style: TextStyle(
//                   color: Colors.green,
//                   fontSize: 30,
//                   fontWeight: FontWeight.w600),
//             ),
//           ),
//           InkWell(
//             child: Center(
//                 child: Image.asset(
//               "assets/images/iconFacebook.png",
//               width: 100,
//               height: 100,
//             )),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Icon(
//                 Icons.phone_in_talk,
//                 color: Colors.black,
//                 size: 30.0,
//               ),
//               Text(
//                 "+96399000000",
//                 style: TextStyle(fontSize: 20.0),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 20.0,
//           ),
//           Align(
//             alignment: Alignment.center,
//             child: Text(
//               "In front of the Italian village".tr(),
//               style: titleName,
//             ),
//           ),
//           Container(
//             height: 2,
//             color: Color(0xFF0569DB),
//           ),
//           SizedBox(
//             height: 20.0,
//           ),
//           Center(
//             child: Container(
//               child: Text(
//                 "Offers made ".tr(),
//                 style: TextStyle(color: Colors.black, fontSize: 30.0),
//               ),
//             ),
//           ),
//           offers2(4000, "Pizza + funker + sandwich + cola".tr()),
//           Container(
//             height: 1,
//             color: Colors.white,
//           ),
//           offers2(3000, "Three pizza + big funker and cola".tr()),
//           Container(
//             height: 1,
//             color: Colors.white,
//           ),
//           offers2(2000, "I made a piece of Kentucky + Finker and Cola".tr()),
//           Container(
//             height: 1,
//             color: Colors.white,
//           ),
//           offers2(7000, "Three kebab meals + medium appetizers for free".tr()),
//           Container(
//             height: 1,
//             color: Colors.white,
//           ),
//           offers2(1000, "A hand of lamb + four cola _dosti barkh".tr()),
//         ],
//       ),
//     ));
//   }

//   final titleName = TextStyle(
//     fontSize: 22.0,
//     fontWeight: FontWeight.w700,
//     fontStyle: FontStyle.italic,
//   );

//   final titlesub = TextStyle(
//     fontSize: 20.0,
//     color: Colors.white,
//     fontWeight: FontWeight.w600,
//   );

//   final titlesub2 = TextStyle(
//     fontSize: 18.0,
//     color: Colors.white,
//     fontWeight: FontWeight.w600,
//   );
//   final titleSlider = TextStyle(
//       fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white);

//   final fonttable1 = TextStyle(
//     color: Color(0xFF4D4D4D),
//   );

//   final fonttable2 = TextStyle(
//     color: Colors.black,
//     fontWeight: FontWeight.w700,
//   );

//   Widget cardShow(var IconProperties, String allTitle, String ThereOrNot) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10.0),
//           color: Colors.blueAccent,
//         ),
//         child: ListTile(
//             contentPadding:
//                 EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//             leading: Container(
//               padding: EdgeInsets.only(right: 12.0),
//               child: Icon(Icons.autorenew, color: Colors.white),
//             ),
//             title: Text(
//               allTitle,
//               style:
//                   TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//             ),
//             // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

//             subtitle: Row(
//               children: <Widget>[
//                 Icon(Icons.linear_scale, color: Colors.green),
//                 Text(ThereOrNot, style: TextStyle(color: Colors.white))
//               ],
//             ),
//             trailing: Icon(IconProperties, color: Colors.white, size: 30.0)),
//       ),
//     );
//   }

//   Widget offers2(int price, String displayAll) {
//     return Container(
//       child: Card(
//         child: Container(
//           color: Color(0xFF0095EBf),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 8, bottom: 8, left: 20),
//                 child: Text(
//                   "$price",
//                   style: titlesub2,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 8, bottom: 8, right: 30),
//                 child: Text(
//                   "$displayAll",
//                   style: titlesub2,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

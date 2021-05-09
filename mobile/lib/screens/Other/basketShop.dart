// import 'package:flutter/material.dart';

// class basketShop extends StatefulWidget {
//   basketShop({Key key}) : super(key: key);

//   @override
//   _basketShopState createState() => _basketShopState();
// }

// class _basketShopState extends State<basketShop> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 50),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(right: 40),
//                     child: Image.asset("assets/images/profile_2.png"),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 20, right: 30),
//                     child: Text(
//                       "الجندول -شورش ",
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 20),
//                     child: Text(
//                       "12,750 د.ع",
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//           backgroundColor: Colors.white,
//           leading: Icon(
//             Icons.keyboard_backspace,
//             color: Colors.black,
//             size: 30.0,
//             // textDirection: TextDirection.rtl,
//           ),
//         ),
//         body: ListView(
//           children: [
//             SizedBox(
//               height: 30,
//             ),
//             myCardChick(),
//             myCardChick(),
//             myCardChick(),
//             Center(
//               child: Text(
//                 "مسح السلة",
//                 style: TextStyle(color: Colors.black87, fontSize: 16),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Align(
//               alignment: Alignment.centerRight,
//               child: Container(
//                   height: 50,
//                   width: MediaQuery.of(context).size.width / 1.8,
//                   decoration: BoxDecoration(
//                     color: Color(0xFF4ED133),
//                     borderRadius: BorderRadius.horizontal(
//                       left: Radius.circular(50.0),
//                       // right: Radius.circular(50.0),
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 8),
//                         child: CircleAvatar(
//                           child: Icon(
//                             Icons.widgets,
//                             color: Colors.white,
//                           ),
//                           backgroundColor: Color(0x56FFFFFF),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 14,
//                       ),
//                       Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(top: 10, left: 24),
//                             child: Text(
//                               "الاستمرار",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           )
//                         ],
//                       )
//                     ],
//                   )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget myCardChick() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 12, right: 12, bottom: 5, top: 5),
//       child: Container(
//         height: MediaQuery.of(context).size.height / 5,
//         child: Card(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
//                     child: Container(
//                       width: 65,
//                       height: 65,
//                       child: Image.asset("assets/images/cake_slice.png"),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 0),
//                     child: Text(
//                       "x1 1,750 د.ع",
//                       style: TextStyle(fontSize: 10, color: Colors.black45),
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.only(bottom: 1),
//                       child: Text(
//                         " د.ع 1,750 ",
//                         style: TextStyle(fontSize: 16, color: Colors.black),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           "لحم بعجين صغير بالبيض ",
//                           style: TextStyle(
//                               color: Colors.black, fontWeight: FontWeight.w400),
//                         ),
//                         Icon(
//                           Icons.delete,
//                           color: Colors.red,
//                         )
//                       ],
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 90),
//                       child: Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 17,
//                             backgroundColor: Color(0xFF000000),
//                             child: CircleAvatar(
//                               radius: 16,
//                               child: Icon(
//                                 Icons.remove,
//                                 color: Colors.black,
//                               ),
//                               backgroundColor: Colors.white,
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 10, right: 10),
//                             child: Text("1"),
//                           ),
//                           CircleAvatar(
//                             radius: 17,
//                             backgroundColor: Color(0xFF000000),
//                             child: CircleAvatar(
//                               radius: 16,
//                               child: Icon(
//                                 Icons.add,
//                                 color: Colors.black,
//                               ),
//                               backgroundColor: Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

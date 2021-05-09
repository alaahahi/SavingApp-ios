// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class ShowProduct extends StatefulWidget {
//   ShowProduct({Key key}) : super(key: key);

//   @override
//   ShowProductState createState() => ShowProductState();
// }

// class ShowProductState extends State<ShowProduct> {
//   int valuesAdd = 0;

//   void decrement() {
//     if (valuesAdd > 0)
//       setState(() {
//         valuesAdd--;
//       });
//   }

//   void increment() {
//     setState(() {
//       valuesAdd++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: Icon(
//           Icons.favorite_border,
//           color: Colors.black,
//           size: 30.0,
//         ),
//         actions: [
//           Container(
//               padding: EdgeInsets.only(top: 16),
//               child: Text(
//                 "Alintele",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black),
//               )),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16),
//             child: Image.asset("assets/images/profile_2.png"),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 10),
//             child: Icon(
//               Icons.keyboard_arrow_left,
//               size: 50.0,
//               color: Colors.black,
//             ),
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: ListView(
//           children: [
//             Image.asset(
//               "assets/images/bread_on_tray.png",
//               fit: BoxFit.fill,
//               width: double.infinity,
//               height: 250,
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Align(
//                 alignment: Alignment.topLeft,
//                 child: Container(
//                     padding: EdgeInsets.only(left: 20),
//                     child: Text(
//                       "سيتر اسبر",
//                       style: TextStyle(
//                           fontSize: 20.0, fontWeight: FontWeight.bold),
//                     ))),
//             SizedBox(
//               height: 40,
//             ),
//             Align(
//                 alignment: Alignment.topLeft,
//                 child: Container(
//                     padding: EdgeInsets.only(left: 20),
//                     child: Text(
//                       "6,000 ل.س",
//                       style: TextStyle(
//                           fontSize: 30.0, fontWeight: FontWeight.bold),
//                     ))),
//             SizedBox(
//               height: 30,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 60),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: 20,
//                   ),
//                   buttenAdd(Icons.remove, () {
//                     decrement();
//                   }),
//                   Container(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Text(
//                         "$valuesAdd",
//                         style: TextStyle(color: Colors.black, fontSize: 40.0),
//                       ),
//                     ),
//                   ),
//                   buttenAdd(Icons.add, () {
//                     increment();
//                   }),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Align(
//               alignment: Alignment.centerRight,
//               child: Container(
//                   height: 50,
//                   width: MediaQuery.of(context).size.width / 2,
//                   decoration: BoxDecoration(
//                     color: Color(0xFF4FD335),
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
//                             Icons.add,
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
//                           textall("اضف المنتج 1"),
//                           textall("6000 ل.س "),
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

//   Widget textall(String textThis) {
//     return Text(
//       textThis,
//       style: TextStyle(
//         color: Colors.white,
//         fontSize: 14,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }

//   Widget buttenAdd(var iconThis, var cliclThis) {
//     return InkWell(
//       onTap: cliclThis,
//       child: Container(
//         width: 70.0,
//         height: 70.0,
//         child: Icon(
//           iconThis,
//           color: Colors.black,
//           size: 40,
//         ),
//         decoration: BoxDecoration(
//           color: Color(0xFFFFFFFF),
//           borderRadius: BorderRadius.all(Radius.circular(50.0)),
//           border: Border.all(
//             color: Color(0xCCBDBDBD),
//             width: 2.0,
//           ),
//         ),
//       ),
//     );
//   }
// }

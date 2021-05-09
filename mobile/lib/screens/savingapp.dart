// import 'package:coupons/screens/Category/category.dart';
// import 'package:coupons/screens/informations.dart';
// import 'package:flutter/material.dart';

// class SavingApp extends StatelessWidget {
//   const SavingApp({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final _kTabPages = <Widget>[
//       Informations(),
//       CategoryPage(),
//     ];
//     final _kTabs = <Tab>[
//       const Tab(icon: Icon(Icons.cloud), text: 'Informations'),
//       const Tab(icon: Icon(Icons.local_dining), text: 'Product'),
//     ];
//     return DefaultTabController(
//       length: _kTabs.length,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('SavingApp'),
//           backgroundColor: Colors.cyan,
//           bottom: TabBar(
//             tabs: _kTabs,
//           ),
//         ),
//         body: TabBarView(
//           children: _kTabPages,
//         ),
//       ),
//     );
//   }
// }

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:coupons/models/CompanyModel.dart';
// import 'package:coupons/screens/Company/company.dart';
// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

// class CompanyItem extends StatelessWidget {
//   const CompanyItem({
//     Key key,
//     @required this.company,
//     @required this.shrink,
//   }) : super(key: key);

//   final CompanyModel company;
//   final bool shrink;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         pushNewScreen(
//           context,
//           screen: CompanyPage(company: this.company),
//         );
//       },
//       child: Container(
//         width: MediaQuery.of(context).size.width * (shrink ? 0.5 : 1.0),
//         child: Card(
//           elevation: 2,
//           margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           child: shrink
//               ? Column(
//                   // crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CachedNetworkImage(
//                       imageUrl: company.photo,
//                       fit: BoxFit.cover,
//                     ),
//                     SizedBox(height: 10),
//                     renderContent(),
//                   ],
//                 )
//               : Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CachedNetworkImage(
//                       imageUrl: company.photo,
//                       fit: BoxFit.cover,
//                       width: 120,
//                       height: 120,
//                     ),
//                     SizedBox(width: 10),
//                     Expanded(child: renderContent()),
//                   ],
//                 ),
//         ),
//       ),
//     );
//   }

//   Widget renderContent() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             company.title,
//             overflow: TextOverflow.ellipsis,
//             maxLines: 2,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 22,
//               color: Colors.grey.shade700,
//             ),
//           ),
//           Text(
//             company.desc,
//             overflow: TextOverflow.ellipsis,
//             maxLines: 2,
//             style: TextStyle(
//               color: Colors.blue.shade200,
//             ),
//           ),
//           SizedBox(height: 10),
//           Text(
//             '09:00 AM - 22:00 PM',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.green.shade300,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

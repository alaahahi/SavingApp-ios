// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';

// class RecentProduct extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         image: DecorationImage(
//           fit: BoxFit.cover,
//           colorFilter: ColorFilter.mode(
//             Colors.red,
//             BlendMode.multiply,
//           ),
//           image: CachedNetworkImageProvider(
//             'https://i4.hurimg.com/i/hurriyet/75/750x422/5d25cdf967b0a90c800e1e4d.jpg',
//           ),
//         ),
//       ),
//       clipBehavior: Clip.hardEdge,
//       height: 150,
//       width: double.infinity,
//       margin: EdgeInsets.symmetric(horizontal: 40),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'Product 321',
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 22,
//             ),
//           ),
//           Text(
//             'from company 321',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 18,
//             ),
//           ),
//           Text(
//             'click for the detials',
//             style: TextStyle(
//               color: Colors.white,
//               fontStyle: FontStyle.italic,
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

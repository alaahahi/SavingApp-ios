// import 'package:coupons/screens/Auth/loginScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// // import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// import 'package:easy_localization/easy_localization.dart';

// class Language extends StatefulWidget {
//   @override
//   _LanguageState createState() => _LanguageState();
// }

// class _LanguageState extends State<Language> {
//   String selected_language;

//   @override
//   Widget build(BuildContext context) {
//     // context.setLocale(Locale('en'));
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("assets/images/splash_image.png"),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset('assets/images/Saving-logo.png'),
//             Text("CHOOSE_LANGUAGE", style: titleHome).tr(),
//             Container(
//               margin: EdgeInsets.all(20),
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(50),
//               ),
//               child: DropdownButton<String>(
//                 underline: Container(),
//                 value: selected_language,
//                 isExpanded: true,
//                 items: <String>['AR', 'EN', 'KU']
//                     .map((String value) => DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value.tr()),
//                         ))
//                     .toList(),
//                 onChanged: (value) {
//                   setState(() => selected_language = value);
//                   EasyLocalization.of(context)
//                       .setLocale(Locale(value.toLowerCase()));
//                   pushNewScreen(
//                     context,
//                     screen: LoginScreen2(),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   final titleHome = TextStyle(
//     color: Colors.indigo,
//     fontWeight: FontWeight.bold,
//     fontSize: 26.0,
//   );
// }

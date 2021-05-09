import 'package:coupons/data/api.dart';
import 'package:coupons/services/authService.dart';
import 'package:coupons/services/activation.dart';
import 'package:coupons/services/likes.dart';
import 'package:coupons/services/cartService.dart';
import 'package:coupons/screens/Auth/loginScreen.dart';
import 'package:coupons/widgets/Layouts/BottomNavBarApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock/wakelock.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Wakelock.enable();
  // setupLocater();
  await FlutterStatusbarManager.setColor(Colors.transparent, animated: true);
  await FlutterStatusbarManager.setNavigationBarColor(
    Colors.white,
    animated: true,
  );
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    Phoenix(
      child: EasyLocalization(
        supportedLocales: [
          Locale('en'),
          Locale('ar'),
          Locale('fa'),
        ],
        useOnlyLangCode: true,
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        child: MainApp(prefs: prefs),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({Key key, this.prefs}) : super(key: key);

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    final appContent = BottomedNavBarApp();
    // EasyLocalization.of(context).setLocale(Locale('fa'));

    return MaterialApp(
      title: 'Saving App'.tr(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          Provider<Api>(
            create: (_) => Api(
              baseUrl: 'https://www.savingapp.co/AdminCp/public/api',
              langFunc: () => EasyLocalization.of(context).locale.languageCode,
            ),
          ),
          Provider<AuthService>(create: (_) => AuthService()),
          Provider<SharedPreferences>(create: (_) => prefs),
          ListenableProvider<Activation>(create: (_) => Activation()),
          ListenableProvider<ProductLikeService>(
            create: (_) => ProductLikeService(prefs: prefs),
          ),
          ListenableProvider<CompanyLikeService>(
            create: (_) => CompanyLikeService(prefs: prefs),
          ),
          ListenableProvider<CartService>(
              create: (_) => CartService(prefs: prefs)),
        ],
        builder: (context, child) => StreamBuilder(
          stream: context.read<AuthService>().onAuthStateChanged,
          builder: (context, snapshot) {
            //return appContent;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            }
            return snapshot.data == null ?  LoginScreen(): appContent;
          },
        ),
      ),
    );
  }
}

import 'package:coupons/screens/Home/home.dart';
import 'package:coupons/screens/Search/search.dart';
import 'package:coupons/screens/Cart/Cart.dart';
import 'package:coupons/screens/Orders/Orders.dart';
import 'package:coupons/screens/Other/gifts.dart';
import 'package:coupons/screens/Other/settings.dart';
import 'package:coupons/screens/Wishlist/wishlist.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BottomedNavBarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: [
        HomePage(),
        Wishlist(),
        SearchPage(),
        CartPage(),
        OrdersPage(), //ShowProduct(),
        SettingsPage(),
//        giftPage(),
      ],

      items: [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home, ),
          title: 'Home'.tr(),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey.shade300,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.favorite_border, ),
          title: 'Wishlist'.tr(),
          activeColorPrimary: Colors.red,
          inactiveColorPrimary: Colors.grey.shade300,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.search),
          title: 'Search'.tr(),
          activeColorPrimary: Colors.orange,
          inactiveColorPrimary: Colors.grey.shade300,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.shopping_cart),
          title: 'Cart'.tr(),
          activeColorPrimary: Colors.purple,
          inactiveColorPrimary: Colors.grey.shade300,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.local_shipping),
          title: 'Order'.tr(),
          activeColorPrimary: Colors.indigo,
          inactiveColorPrimary: Colors.grey.shade300,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(
            Icons.person,
          ),
          title: 'Settings'.tr(),
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.grey.shade300,
        ),

//        PersistentBottomNavBarItem(
//          icon: Icon(
//            Icons.shopping_basket,
//          ),
//          title: 'Gifts',
//          activeColorPrimary: Colors.green,
//          inactiveColorPrimary: Colors.grey.shade300,
//        ),
      ],
      // confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      // stateManagement: true,

      navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
          ? 0.0
          : kBottomNavigationBarHeight,

      hideNavigationBarWhenKeyboardShows: true,
      popActionScreens: PopActionScreensType.all,
      bottomScreenMargin: 0,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 4.0)],
      ),
      popAllScreensOnTapOfSelectedTab: false,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        curve: Curves.ease,
        duration: Duration(milliseconds: 300),
      ),
      navBarStyle: NavBarStyle.style4,
    );
  }
}

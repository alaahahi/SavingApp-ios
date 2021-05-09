import 'package:coupons/models/GiftModel.dart';
import 'package:coupons/screens/Other/gifts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:easy_localization/easy_localization.dart';

class freeGifts extends StatelessWidget {
  const freeGifts({Key key, this.isGrid = false, this.gift}) : super(key: key);
  final bool isGrid;
  final GiftModel gift;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: InkWell(
        onTap: () => pushNewScreen(context, screen: GiftPage()),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            width: MediaQuery.of(context).size.width / 1.1,
            height: 65,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.asset(
                    'assets/images/giftFree.jpeg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Free Gifts".tr(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

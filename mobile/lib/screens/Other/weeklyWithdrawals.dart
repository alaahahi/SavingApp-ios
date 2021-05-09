import 'package:coupons/screens/Other/weeklyPullPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:easy_localization/easy_localization.dart';

class weeklyWithdrawals extends StatelessWidget {
  const weeklyWithdrawals({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: InkWell(
        onTap: () => pushNewScreen(context,
            screen: weeklyPullPage(
              isGrid: false,
            )),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            width: MediaQuery.of(context).size.width / 1.1,
            height: 70,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.asset(
                    'assets/images/giftwithdrawals.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Weekly and Monthly Withdrawals".tr(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

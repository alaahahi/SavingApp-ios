import 'package:coupons/data/api.dart';
import 'package:coupons/models/SearchResult.dart';
import 'package:coupons/screens/Other/freeGifts.dart';
import 'package:coupons/screens/Other/weeklyWithdrawals.dart';
import 'package:coupons/screens/Search/RandomCategoryList.dart';
import 'package:coupons/widgets/Cards/InfoCard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:coupons/widgets/common/RowTitle.dart';
import 'package:coupons/widgets/common/OfferList.dart';
import 'package:coupons/screens/Home/profileRow.dart';
import 'package:coupons/screens/Home/ActivationBox.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 60),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
//
              SizedBox(height: 20),
              ProfileRow(),
              ActivationBox(),
              SizedBox(height: 20),

              RandomCategoryList(),

              freeGifts(),

              SizedBox(height: 10),

              FutureBuilder<SearchResult>(
                future: context.read<Api>().getHome(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return Column(
                      children: [
                        RowTitle(title: 'Featured Offers'.tr()),
                        OfferList(list: snapshot.data.products),
                        // RowTitle(title: 'Trending Restaurants'),
                        // CompanyList(),
                        weeklyWithdrawals(),

                        RowTitle(title: 'Featured Companies'.tr()),

                        Column(
                          children: snapshot.data.companies
                              .map((e) => InfoCard(company: e, vertical: false))
                              .toList(),
                        )
                        // RowTitle(title: 'Populer Stores'),
                        // CompanyList(),
                      ],
                    );
                  }

                  return Center(child: CircularProgressIndicator());
                },
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

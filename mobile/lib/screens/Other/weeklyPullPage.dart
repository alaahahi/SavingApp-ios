import 'package:coupons/models/WeeklyAndMonthlyPullModel.dart';
import 'package:coupons/widgets/Items/WeeklyPullItem.dart';
import 'package:coupons/widgets/Layouts/StyledAppBar.dart';
import 'package:flutter/material.dart';
import 'package:coupons/data/api.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class weeklyPullPage extends StatelessWidget {
  const weeklyPullPage({Key key, this.isGrid = false}) : super(key: key);
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    Widget textTitle(String title, var colorTitle) {
      return Padding(
        padding:
            const EdgeInsets.only(right: 25, left: 25, bottom: 12, top: 12),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6), color: colorTitle),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            )),
      );
    }

    return Scaffold(
      appBar: StyledAppBar(
        title: 'Names Of The Winners'.tr(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: FutureBuilder(
          future: context.read<Api>().getWeeklyAndMonthlyPull(),
          builder: (context,
              AsyncSnapshot<List<WeeklyAndMonthlyPullModel>> snapshot) {
            if (snapshot.hasError) {
              return Column(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Text(
                    snapshot.error.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              );
            }
            if (snapshot.hasData) {
              return Container(
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(bottom: 30),
                  children: [
                    textTitle("Monthly Withdrawals".tr(), Colors.blue),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: monthlyGift(context, snapshot.data),
                      ),
                    ),
                    textTitle("Weekly Withdrawals".tr(), Colors.red),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: weeklyGift(context, snapshot.data),
                      ),
                    ),
                    textTitle("Points Withdrawals".tr(), Colors.green),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: pointe(context, snapshot.data),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(child: CircularProgressIndicator()),
            );
          },
        ),
      ),
    );
  }

  List<Widget> pointe(
      BuildContext context, List<WeeklyAndMonthlyPullModel> data) {
    return data.map((winner) {
      if (winner.type == "Pointe") {
        return weeklyPullItem(
          weeklyAndMonthlyPullModel: winner,
          title: winner.title,
          phont: winner.phont,
          date: winner.date.toString(),
          type: winner.type,
          desc: winner.desc,
          phone: winner.phone,
        );
      } else {
        return Container();
      }
    }).toList();
  }
}

List<Widget> monthlyGift(
    BuildContext context, List<WeeklyAndMonthlyPullModel> data) {
  return data.map((winner) {
    if (winner.type == "Monthly") {
      return weeklyPullItem(
        weeklyAndMonthlyPullModel: winner,
        title: winner.title,
        phont: winner.phont,
        date: winner.date.toString(),
        type: winner.type,
        desc: winner.desc,
        phone: winner.phone,
      );
    } else {
      return Container();
    }
  }).toList();
}

List<Widget> weeklyGift(
    BuildContext context, List<WeeklyAndMonthlyPullModel> data) {
  return data.map((winner) {
    if (winner.type == "Weekly") {
      return weeklyPullItem(
        weeklyAndMonthlyPullModel: winner,
        title: winner.title,
        phont: winner.phont,
        date: winner.date.toString(),
        type: winner.type,
        desc: winner.desc,
        phone: winner.phone,
        name: winner.name,
      );
    } else {
      return Container();
    }
  }).toList();
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coupons/data/api.dart';
import 'package:coupons/widgets/Items/showGift.dart';

import 'package:coupons/models/GiftModel.dart';

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class RandomGiftList extends StatelessWidget {
  const RandomGiftList({Key key, this.isGrid = false}) : super(key: key);
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<Api>().getGift(),
      builder: (context, AsyncSnapshot<List<GiftModel>> snapshot) {
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
          return ListView(
            children: [
              textTitle("Gift Points".tr(), Colors.blue),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: renderPoints(context, snapshot.data),
                ),
              ),
              textTitle("Gift Weekly".tr(), Colors.red),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: renderWeekly(context, snapshot.data),
                ),
              ),
              textTitle("Monthly Gifts".tr(), Colors.green),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: renderMonthly(context, snapshot.data),
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  List<Widget> renderPoints(BuildContext context, List<GiftModel> data) {
    return data.map((winner) {
      if (winner.gift_type_id == 2) {
        return GiftButton(
            textName: winner.title,
            imgItem: winner.icon,
            level_points: winner.levelPoints.toString(),
            onClick: () {
              pushNewScreen(
                context,
                screen: showGift(
                  giftModel: winner,
                ),
              );
            });
      } else {
        return Container();
      }
    }).toList();
  }

  List<Widget> renderWeekly(BuildContext context, List<GiftModel> data) {
    return data.map((winner) {
      if (winner.gift_type_id == 4) {
        return GiftButton(
            textName: winner.giftTranslation.title,
            imgItem: winner.icon,
            level_points: "",
            onClick: () {
              pushNewScreen(
                context,
                screen: showGift(
                  giftModel: winner,
                ),
              );
            });
      } else {
        return Container();
      }
    }).toList();
  }
}

List<Widget> renderMonthly(BuildContext context, List<GiftModel> data) {
  return data.map((winner) {
    if (winner.gift_type_id == 3) {
      return GiftButton(
          textName: winner.giftTranslation.title,
          imgItem: winner.icon,
          level_points: "",
          onClick: () {
            pushNewScreen(
              context,
              screen: showGift(
                giftModel: winner,
              ),
            );
          });
    } else {
      return Container();
    }
  }).toList();
}

class GiftButton extends StatelessWidget {
  const GiftButton({
    Key key,
    this.textName,
    this.imgItem,
    this.onClick,
    this.level_points,
    this.gift_type_id,
    this.giftTranslation,
  }) : super(key: key);

  final String textName, imgItem, level_points;
  final gift_type_id;
  final void Function() onClick;
  final GiftTranslation giftTranslation;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: onClick,
        child: Container(
          height: 80,
          margin: EdgeInsets.all(10),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CachedNetworkImage(
                imageUrl: imgItem,
                fit: BoxFit.cover,
              ),
              Text(textName),
              Text(level_points),
            ],
          ),
        ),
      ),
    );
  }
}

Widget textTitle(String title, var colorTitle) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5, left: 25, right: 25),
    child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: colorTitle,
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        )),
  );
}

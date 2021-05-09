import 'package:cached_network_image/cached_network_image.dart';
import 'package:coupons/models/GiftModel.dart';
import 'package:coupons/widgets/Layouts/StyledAppBar.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class showGift extends StatelessWidget {
  final GiftModel giftModel;

  const showGift({Key key, this.giftModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar(
        title: "My Gift".tr(),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8, left: 8),
              child: Container(
                width: MediaQuery.of(context).size.height / 3,
                margin: EdgeInsets.all(10),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white,
                ),
                child: CachedNetworkImage(
                  imageUrl: giftModel.phont,
                  width: MediaQuery.of(context).size.width / 3,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
                child: textShow(
                    giftModel.giftTranslation.title, Colors.amber, 24)),
            textShow(giftModel.giftTranslation.desc, Colors.blue.shade600, 18),
            SizedBox(
              height: 30,
            ),
            CachedNetworkImage(
              imageUrl: giftModel.icon,
              width: MediaQuery.of(context).size.width / 5,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }

  Widget textShow(String textShow, var colorText, double textSize) {
    return Align(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          textShow,
          style: TextStyle(
            color: colorText,
            fontSize: textSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

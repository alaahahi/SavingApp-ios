import 'package:cached_network_image/cached_network_image.dart';

import 'package:coupons/models/GiftModel.dart';
import 'package:flutter/material.dart';

class GiftCard extends StatelessWidget {
  final GiftModel giftModel;
  final Function onClick;

  const GiftCard({Key key, this.giftModel, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: 100,
        width: 250,
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: giftModel.phont,
              fit: BoxFit.cover,
            ),
            CachedNetworkImage(
              imageUrl: giftModel.icon,
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                Text("${giftModel.levelPoints}"),
                Text(giftModel.title),
              ],
            )
          ],
        ),
      ),
    );
  }
}

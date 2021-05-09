import 'package:coupons/Utils/ColorUtils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({
    Key key,
    this.title,
    this.icon,
    this.imageUrl,
    this.color,
    this.onTap,
    this.height,
    this.width,
  }) : super(key: key);

  final String title;
  final String imageUrl;
  final IconData icon;
  final Color color;
  final Function onTap;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.all(10),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(1, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        child: InkWell(
          splashColor: Colors.white.withOpacity(0.3),
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: [
                  ColorUtil.darken(color),
                  ColorUtil.lighten(color),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 30,
                ),
                Text(
                  title,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

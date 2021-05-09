import 'package:coupons/Utils/ColorUtils.dart';
import 'package:flutter/material.dart';

class CardTags extends StatelessWidget {
  final String title;
  final Color color;

  CardTags({@required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(13, 0, 0, 0),
            offset: Offset(0, 3.33333),
            blurRadius: 33,
          )
        ],
        color: color,
        gradient: LinearGradient(
          begin: Alignment(0.9661, 0.5),
          end: Alignment(0, 0.5),
          stops: [0, 1],
          colors: [
            ColorUtil.lighten(color),
            color,
          ],
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}

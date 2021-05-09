import 'package:cached_network_image/cached_network_image.dart';
import 'package:coupons/models/WeeklyAndMonthlyPullModel.dart';
import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class weeklyPullItem extends StatelessWidget {
  final WeeklyAndMonthlyPullModel weeklyAndMonthlyPullModel;

  final double width, height;

  final bool vertical;
  final String phont, title, desc, type, phone, date,name;

  // final GestureTapCallback onTap;

  weeklyPullItem({
    @required this.weeklyAndMonthlyPullModel,
    this.width,
    this.height,
    // this.onTap,
    this.vertical = true,
    this.phont,
    this.title,
    this.desc,
    this.type,
    this.phone,
    this.date,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 7),
      child: InkWell(
        onTap: () {
//        pushNewScreen(context, screen: CompanyPage(company: company));
          print("a");
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3.5,
          child: Card(
            elevation: 2,
            clipBehavior: Clip.hardEdge,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            child: Stack(
              children: <Widget>[
                renderContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget renderContent() {
    if (vertical)
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            flex: 3,
            child: renderImage(),
          ),
          Flexible(
            flex: 5,
            child: renderText(),
          ),
        ],
      );

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Flexible(
          flex: 3,
          child: renderImage(),
        ),
        Flexible(
          flex: 5,
          child: renderText(),
        ),
      ],
    );
  }

  Widget renderText() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                weeklyAndMonthlyPullModel.title,
                textAlign: TextAlign.left,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 30,
                child: ListView(
                  children: [
                    Text(
                      weeklyAndMonthlyPullModel.desc,
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                weeklyAndMonthlyPullModel.name==null ?
                weeklyAndMonthlyPullModel.phone
                    :weeklyAndMonthlyPullModel.name,
                textDirection: ui.TextDirection.ltr,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: 80,
                child: Text(
                  weeklyAndMonthlyPullModel.date.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                weeklyAndMonthlyPullModel.type,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  CachedNetworkImage renderImage() {
    if (weeklyAndMonthlyPullModel.phont == null ||
        weeklyAndMonthlyPullModel.phont.isEmpty) return renderErrorImage();
    return CachedNetworkImage(
      imageUrl: weeklyAndMonthlyPullModel.phont,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      errorWidget: (_, __, ____) => renderErrorImage(),
    );
  }

  CachedNetworkImage renderErrorImage() {
    return CachedNetworkImage(
      imageUrl: 'NoImagePlaceHolder'.tr(),
      fit: BoxFit.cover,
    );
  }
}

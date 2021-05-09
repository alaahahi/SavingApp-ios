import 'package:cached_network_image/cached_network_image.dart';
import 'package:coupons/models/CompanyModel.dart';
import 'package:coupons/screens/Company/company.dart';
import 'package:coupons/services/likes.dart';
import 'package:coupons/widgets/Cards/CardTags.dart';
import 'package:coupons/widgets/Cards/LikeButton.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class InfoCard extends StatelessWidget {
  final CompanyModel company;

  final double width;
  final double height;
  final bool vertical;
  // final GestureTapCallback onTap;

  InfoCard({
    @required this.company,
    this.width,
    this.height,
    // this.onTap,
    this.vertical = true,
  });

  double getWidth(BuildContext context) {
    return width ??
        (vertical ? MediaQuery.of(context).size.width * 0.5 : double.infinity);
  }

  double getHeight(BuildContext context) {
    return height ?? (vertical ? 240 : 140);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushNewScreen(context, screen: CompanyPage(company: company));
      },
      child: Container(
        width: getWidth(context),
        height: getHeight(context),
        child: Card(
          elevation: 2,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          child: Stack(
            children: <Widget>[
              renderContent(),
              Positioned(
                top: vertical ? 0 : null,
                bottom: vertical ? null : 0,
                right: EasyLocalization.of(context).locale.languageCode == 'en'
                    ? 0
                    : null,
                left: EasyLocalization.of(context).locale.languageCode == 'en'
                    ? null
                    : 0,
                child: LikeButton<CompanyLikeService>(id: company.id),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget renderContent() {
    if (vertical)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            flex: 5,
            child: renderImage(),
          ),
          Flexible(
            flex: 3,
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
                company.title,
                textAlign: TextAlign.left,
                maxLines: vertical ? 1 : 2,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                company.desc,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (company.category != null && company.category.isNotEmpty)
                CardTags(title: company.category, color: Colors.orange),
              SizedBox(width: 5.0),
              CardTags(
                title: company.isOpen ? 'open'.tr() : 'closed'.tr(),
                color: company.isOpen ? Colors.green : Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  CachedNetworkImage renderImage() {
    if (company.photo == null || company.photo.isEmpty)
      return renderErrorImage();
    return CachedNetworkImage(
      imageUrl: company.photo,
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

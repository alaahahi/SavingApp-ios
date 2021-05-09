import 'package:coupons/data/api.dart';
import 'package:coupons/models/CompanyModel.dart';
import 'package:coupons/models/ProductModel.dart';
import 'package:coupons/services/likes.dart';
import 'package:coupons/widgets/Cards/InfoCard.dart';
import 'package:coupons/widgets/Cards/LikableCard.dart';
import 'package:coupons/widgets/Layouts/StyledAppBar.dart';
import 'package:coupons/widgets/common/RemoteList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:coupons/widgets/common/RowTitle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar(title: 'Wishlist'.tr()),
      body: ListView(
        children: [
          RowTitle(title: 'Stores'.tr()),
          Container(
            height: 260,
            width: double.infinity,
            child: Consumer<CompanyLikeService>(
              builder: (_, service, __) => service.isEmpty
                  ? renderEmpty()
                  : RemoteList<CompanyModel>(
                      future: context
                          .read<Api>()
                          .getCompaniesByIds(ids: service.items),
                      ifEmpty: renderEmpty(),
                      scrollDirection: Axis.horizontal,
                      filler: (item) => InfoCard(company: item, width: 280),
                    ),
            ),
          ),
          RowTitle(title: 'Products'.tr()),
          Container(
            height: 320,
            width: double.infinity,
            child: Consumer<ProductLikeService>(
              builder: (_, service, __) => service.isEmpty
                  ? renderEmpty()
                  : RemoteList<ProductModel>(
                      future: context
                          .read<Api>()
                          .getProductByIds(ids: service.items),
                      scrollDirection: Axis.horizontal,
                      ifEmpty: renderEmpty(),
                      filler: (item) => LikableCard(product: item),
                    ),
            ),
          ),
          SizedBox(height: 200),
        ],
      ),
    );
  }

  Widget renderEmpty() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Icon(
            Icons.favorite_rounded,
            size: 80,
            color: Colors.grey.shade200,
          ),
        ),
        Text(
          'Looks like you have not favorited any item yet'.tr(),
          style: TextStyle(
            color: Colors.grey.shade400,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}

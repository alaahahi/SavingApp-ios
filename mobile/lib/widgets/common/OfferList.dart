import 'package:coupons/models/ProductModel.dart';
import 'package:coupons/widgets/Cards/LikableCard.dart';
import 'package:flutter/material.dart';

class OfferList extends StatelessWidget {
  const OfferList({
    Key key,
    @required this.list,
  }) : super(key: key);

  final List<ProductModel> list;

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) return Container();
    return Container(
      height: MediaQuery.of(context).size.height / 2.2,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(width: 30),
        padding: EdgeInsets.symmetric(horizontal: 40),
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) => LikableCard(product: list[index]),
      ),
    );
  }
}

import 'package:coupons/models/SearchResult.dart';
import 'package:coupons/widgets/Cards/InfoCard.dart';
import 'package:coupons/widgets/Cards/LikableCard.dart';
import 'package:coupons/widgets/common/RowTitle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SearchResultList extends StatefulWidget {
  const SearchResultList({
    Key key,
    this.result,
  }) : super(key: key);

  final SearchResult result;

  @override
  _SearchResultListState createState() => _SearchResultListState();
}

class _SearchResultListState extends State<SearchResultList> {
  int showCompaniesCount = 5;

  int showProductsCount = 10;

  @override
  Widget build(BuildContext context) {
    if (widget.result == null ||
        (widget.result.companies.isEmpty && widget.result.products.isEmpty))
      return Container(
        margin: EdgeInsets.all(10),
        child: Center(
          child: Text('Nothing found, try diffrent keywards'.tr()),
        ),
      );

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RowTitle(
              title: 'Companies'.tr() + ' (${widget.result.companies.length})'),
          ...widget.result.companies
              .take(showCompaniesCount)
              .map((e) => InfoCard(
                    company: e,
                    vertical: false,
                  ))
              .toList(),
          if (showCompaniesCount < widget.result.companies.length)
            TextButton(
                child: Icon(Icons.keyboard_arrow_down_outlined, size: 40),
                onPressed: () {
                  setState(() {
                    showCompaniesCount = showCompaniesCount + 5;
                  });
                }),
          Divider(),
          RowTitle(
              title: 'Products'.tr() + ' (${widget.result.products.length})'),
          ...widget.result.products
              .take(showProductsCount)
              .map((e) => LikableCard(product: e, vertical: false))
              .toList(),
          if (showProductsCount < widget.result.products.length)
            TextButton(
                child: Icon(Icons.keyboard_arrow_down_outlined, size: 50),
                onPressed: () {
                  setState(() {
                    showProductsCount = showProductsCount + 10;
                  });
                }),
          Divider(),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}

import 'package:coupons/services/searchHistoryService.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchHistoryList extends StatelessWidget {
  const SearchHistoryList({
    Key key,
    this.keyword,
    this.onClick,
  }) : super(key: key);

  final String keyword;
  final void Function(String keyword) onClick;

  @override
  Widget build(BuildContext context) {
    final String lang = EasyLocalization.of(context).locale.languageCode;
    final service = context.watch<SearchHistoryService>();
    return Column(
      children: service
          .getItems(lang: lang, keyword: keyword)
          .map((x) => ListTile(
                leading: Icon(Icons.history),
                title: Text(x),
                onTap: () => onClick(x),
                trailing: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => service.remove(item: x, lang: lang),
                ),
              ))
          .toList(),
    );
  }
}

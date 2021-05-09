import 'package:coupons/data/api.dart';
import 'package:coupons/models/SearchResult.dart';
import 'package:coupons/screens/Search/RandomCategoryList.dart';
import 'package:coupons/screens/Search/SearchHistoryList.dart';
import 'package:coupons/screens/Search/SearchResultList.dart';
import 'package:coupons/screens/Search/SearchStatue.dart';
import 'package:coupons/services/searchHistoryService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController tcontroler = TextEditingController();
  SearchStatue searchStatue = SearchStatue.init;
  // FocusNode focusNode;
  SearchResult searchResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ListenableProvider<SearchHistoryService>(
            create: (_) => SearchHistoryService(
              prefs: context.read<SharedPreferences>(),
            ),
            builder: (context, child) => Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      if (searchStatue != SearchStatue.init)
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            tcontroler.clear();
                            FocusScope.of(context).unfocus();
                            setState(() {
                              searchStatue = searchStatue ==
                                          SearchStatue.result ||
                                      searchStatue == SearchStatue.typing ||
                                      searchStatue == SearchStatue.beforeTyping
                                  ? SearchStatue.init
                                  : SearchStatue.beforeTyping;
                            });
                          },
                        ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade200,
                          ),
                          child: TextField(
                            controller: tcontroler,
                            autofocus: false,
                            keyboardType: TextInputType.text,
                            // focusNode: focusNode,
                            textInputAction: TextInputAction.search,
                            onSubmitted: (str) async {
                              await doSearch(query: str);
                              context.read<SearchHistoryService>().add(
                                    item: str,
                                    lang: EasyLocalization.of(context)
                                        .locale
                                        .languageCode,
                                  );
                            },
                            onTap: () {
                              if (searchStatue != SearchStatue.typing)
                                setState(() {
                                  searchStatue = SearchStatue.beforeTyping;
                                });
                            },
                            onChanged: (str) {
                              setState(() {
                                searchStatue = str.isEmpty
                                    ? SearchStatue.beforeTyping
                                    : SearchStatue.typing;
                              });
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter a search term'.tr(),
                            ),
                          ),
                        ),
                      ),
                      if (searchStatue == SearchStatue.loading)
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.black),
                          ),
                        ),
                      if (searchStatue != SearchStatue.loading)
                        IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              doSearch();
                              context.read<SearchHistoryService>().add(
                                    item: tcontroler.value.text,
                                    lang: EasyLocalization.of(context)
                                        .locale
                                        .languageCode,
                                  );
                            }),
                    ],
                  ),
                ),
                if (searchStatue == SearchStatue.typing ||
                    searchStatue == SearchStatue.beforeTyping)
                  SearchHistoryList(
                    keyword: tcontroler.value.text,
                    onClick: (x) {
                      tcontroler.text = x;
                      doSearch(query: x);
                    },
                  ),
                Divider(),
                if (searchStatue == SearchStatue.result)
                  SearchResultList(result: searchResult),
                if (searchStatue == SearchStatue.error)
                  Text('Something does not add up'.tr() +
                      ' ' +
                      'Please try again later'.tr()),
                if (searchStatue != SearchStatue.result)
                  RandomCategoryList(isGrid: true),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> doSearch({String query}) async {
    if (query == null) {
      query = tcontroler.text;
    }
    if (query.isEmpty) {
      return;
    }
    FocusScope.of(context).unfocus();

    setState(() {
      searchStatue = SearchStatue.loading;
    });

    try {
      SearchResult res = await context.read<Api>().search(query: query);

      setState(() {
        searchResult = res;
        searchStatue = SearchStatue.result;
      });
    } catch (ex) {
      Fluttertoast.showToast(msg: ex.message);
      setState(() {
        searchStatue = SearchStatue.error;
      });
    }
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryService extends ChangeNotifier {
  final String _storage_key_ = '_search_history_';
  final SharedPreferences prefs;

  SearchHistoryService({this.prefs});

  List<String> getItems({
    @required String lang,
    String keyword,
    int take = 5,
  }) {
    return (prefs.getStringList('$_storage_key_$lang'))
            ?.where(_isStartWith(keyword))
            ?.take(take)
            ?.toList() ??
        <String>[];
  }

  bool Function(String) _isStartWith(String keyword) {
    if (keyword == null || keyword.isEmpty) {
      return (a) => true;
    }

    String k = keyword.toLowerCase().trim();
    return (a) => a.toLowerCase().trim().startsWith(k);
  }

  bool Function(String) _isSame(String keyword) {
    String k = keyword.toLowerCase().trim();
    return (a) => a.toLowerCase().trim().startsWith(k);
  }

  void add({
    @required String item,
    @required String lang,
  }) {
    _remove(
      item: item,
      lang: lang,
      afterRemoving: (_items) => _items.insert(0, item),
    );
  }

  void remove({
    @required String item,
    @required String lang,
  }) {
    _remove(item: item, lang: lang);
  }

  void _remove({
    String item,
    String lang,
    void Function(List<String>) afterRemoving,
  }) {
    List<String> _items = getItems(lang: lang, take: 40);
    _items.removeWhere(_isSame(item));

    if (afterRemoving != null) afterRemoving(_items);

    notifyListeners();
    prefs.setStringList('$_storage_key_$lang', _items);
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageSourceNotifier extends ChangeNotifier {
  final String storageKey;
  final SharedPreferences prefs;

  StorageSourceNotifier({
    this.storageKey,
    this.prefs,
  });

  Future<void> store(List<int> items) async {
    await prefs.setStringList(
      storageKey,
      items.map((e) => e.toString()).toList(),
    );
    notifyListeners();
  }

  List<int> fetch() {
    final list = prefs.getStringList(storageKey);
    return list == null ? [] : list.map((e) => int.parse(e)).toList();
  }
}

abstract class LikeService extends StorageSourceNotifier {
  List<int> _items;

  LikeService({
    String storageKey,
    SharedPreferences prefs,
  }) : super(storageKey: storageKey, prefs: prefs) {
    _items = fetch();
  }

  List<int> get items => _items.toList();

  bool get isEmpty => _items.isEmpty;
  int get count => _items.length;

  void toggle(int id) {
    if (!_items.remove(id)) {
      _items.add(id);
    }

    store(_items);
  }

  bool isLiked(int id) {
    return _items.indexOf(id) != -1;
  }
}

class ProductLikeService extends LikeService {
  ProductLikeService({SharedPreferences prefs})
      : super(
          storageKey: '_product_likes_',
          prefs: prefs,
        );
}

class CompanyLikeService extends LikeService {
  CompanyLikeService({SharedPreferences prefs})
      : super(
          storageKey: '_company_likes_',
          prefs: prefs,
        );
}

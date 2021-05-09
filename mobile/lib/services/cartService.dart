import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:coupons/services/CartItem.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService extends ChangeNotifier {
  final SharedPreferences prefs;
  final String _storage_key_ = '_product_in_cart_';

  CartService({this.prefs}) {
    final data = prefs.get(_storage_key_);
    if (data == null) {
      _items = <CartItem>[];
    } else {
      _items = (json.decode(data) as List<dynamic>)
          .map((e) => CartItem.fromJson(e))
          .toList();
    }
  }

  List<CartItem> _items;
  List<int> get ids => _items.map((e) => e.id).toList();

  bool get isEmpty => _items.isEmpty;
  int get count => _items.length;

  Future<void> change(int id, int quantity) async {
    CartItem item = _find(id);
    if (item == null) {
      if (quantity <= 0) {
        return;
      }
      _items.add(CartItem(id: id, quantity: quantity));
    } else {
      if (quantity <= 0) {
        _items.removeWhere((x) => x.id == id);
      } else
        item.quantity = quantity;
    }

    notifyListeners();

    await _storeToLocal();
  }

  Future<void> removeItems(List<int> ids) async {
    _items.removeWhere((x) => ids.contains(x.id));
    notifyListeners();
    await _storeToLocal();
  }

  Future<void> _storeToLocal() async {
    await prefs.setString(_storage_key_, json.encode(_items));
  }

  CartItem _find(int id) {
    return _items.firstWhere((x) => x.id == id, orElse: () => null);
  }

  int getQunatity(int id) {
    return _find(id)?.quantity ?? 0;
  }

  bool isCarted(int id) {
    return getQunatity(id) > 0;
  }

  List<CartItem> getByIds(List<int> ids) {
    return _items.where((x) => ids.contains(x.id)).toList();
  }
}

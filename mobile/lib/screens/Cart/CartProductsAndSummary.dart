import 'package:coupons/data/api.dart';
import 'package:coupons/models/ProductModel.dart';
import 'package:coupons/screens/Cart/CartSummary.dart';
import 'package:coupons/services/authService.dart';
import 'package:coupons/services/cartService.dart';
import 'package:coupons/widgets/Cards/LikableCard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CartProductsAndSummary extends StatelessWidget {
  const CartProductsAndSummary({Key key, @required this.products})
      : super(key: key);

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartService>(context);
    return ListView(
      shrinkWrap: true,
      children: [
        Column(
          children: products
              .map((item) => Column(children: [
                    LikableCard(
                      product: item,
                      vertical: false,
                    ),
                    SizedBox(height: 30)
                  ]))
              .toList(),
        ),
        CartSummary(
          subTotal: subTotal(cart, products),
          saving: discount(cart, products),
          total: total(cart, products),
          onCheckout: (void Function(bool) setLoader) async {
            try {
              setLoader(true);
              final ids = products.map((e) => e.id).toList();
              final user = await context.read<AuthService>().user;
              final msg = await context.read<Api>().submitOrder(
                    items: cart.getByIds(ids),
                    phone: user.phoneNumber,
                  );
              await cart.removeItems(ids);
              Fluttertoast.showToast(msg: msg);
            } catch (e) {
              Fluttertoast.showToast(
                msg:
                      'Some error happened, Try again'.tr() + '\n' + e.toString(),
              );
            }
            setLoader(false);
          },
        ),
        SizedBox(height: 150),
      ],
    );
  }

  int totalCount(CartService cart, List<ProductModel> products) {
    if (products == null || products.isEmpty) return 0;
    return products.map((e) => cart.getQunatity(e.id)).reduce((a, b) => a + b);
  }

  int subTotal(CartService cart, List<ProductModel> products) {
    if (products == null || products.isEmpty) return 0;
    final res = products
        .map((e) => cart.getQunatity(e.id) * e.price)
        .reduce((a, b) => a + b);
    return res.round();
  }

  int discount(CartService cart, List<ProductModel> products) {
    if (products == null || products.isEmpty) return 0;
    final res = products
        .map((e) =>
            cart.getQunatity(e.id) *
            (e.discountPrice == null ? 0 : (e.price - e.discountPrice).abs()))
        .reduce((a, b) => a + b);
    return res.round();
  }

  int total(CartService cart, List<ProductModel> products) {
    if (products == null || products.isEmpty) return 0;
    final res = products
        .map((e) => cart.getQunatity(e.id) * (e.discountPrice ?? e.price))
        .reduce((a, b) => a + b);
    return res.round();
  }
}

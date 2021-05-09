import 'package:coupons/data/api.dart';
import 'package:coupons/models/ProductModel.dart';
import 'package:coupons/screens/Cart/CartProductsAndSummary.dart';
import 'package:coupons/screens/Cart/CompanyTabProvider.dart';
import 'package:coupons/screens/Cart/ProductCompanyTabs.dart';
import 'package:coupons/widgets/Layouts/StyledAppBar.dart';
import 'package:coupons/services/cartService.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar(title: 'Cart'.tr()),
      body: Selector<CartService, List<int>>(
        selector: (_, value) => value.ids,
        // shouldRebuild: (previous, next) => previous.length < next.length|| previous,
        builder: (_, ids, __) => ids.isEmpty
            ? renderEmpty()
            : FutureBuilder<List<ProductModel>>(
                future: context.read<Api>().getProductByIds(ids: ids),
                builder: (_, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData && snapshot.data.length > 0)
                    return Consumer<CartService>(
                      builder: (_, cart, __) => renderItemsOrEmpty(
                        snapshot.data
                            .where((x) => cart.getQunatity(x.id) > 0)
                            .toList(),
                      ),
                    );

                  // if (snapshot.hasError) {
                  //   return Text('error');
                  // }
                  return renderEmpty();
                },
              ),
      ),
    );
  }

  Widget renderItemsOrEmpty(List<ProductModel> products) {
    if (products.isEmpty) {
      return renderEmpty();
    }
    return ListenableProvider<CompanyTabProvider>(
      create: (_) => CompanyTabProvider(),
      builder: (context, child) => Column(
        children: [
          ProductCompanyTabs(
            companyIds: products.map((e) => e.companyId).toList(),
          ),
          Divider(),
          Expanded(
            child: Consumer<CompanyTabProvider>(
              builder: (_, tabs, __) =>
                  products.any((x) => tabs.isSelected(x.companyId)) == false
                      ? renderEmpty()
                      : CartProductsAndSummary(
                          products: products
                              .where((x) => tabs.isSelected(x.companyId))
                              .toList(),
                        ),
            ),
          ),
        ],
      ),
    );
  }

  Widget renderEmpty() {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.remove_shopping_cart,
            color: Colors.grey.shade200,
            size: 300,
          ),
          Text(
            'No items in your cart'.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              color: Colors.grey.shade300,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

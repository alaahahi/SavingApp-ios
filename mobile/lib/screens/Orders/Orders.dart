import 'package:coupons/data/api.dart';
import 'package:coupons/screens/Orders/OrderCard.dart';
import 'package:coupons/services/authService.dart';
import 'package:coupons/models/OrderModel.dart';
import 'package:coupons/widgets/Layouts/StyledAppBar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar(title: 'Orders'.tr()),
      body: FutureBuilder<User>(
        future: context.read<AuthService>().user,
        builder: (context, user) => !user.hasData
            ? Center(child: CircularProgressIndicator())
            : FutureBuilder<List<OrderModel>>(
                future:
                    context.read<Api>().getOrders(phone: user.data.phoneNumber),
                builder: (context, orders) {
                  if (orders.hasData) {
                    if (orders.data.isEmpty)
                      return Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(height: 100),
                            Icon(
                              Icons.local_shipping_outlined,
                              color: Colors.grey.shade200,
                              size: 240,
                            ),
                            Text(
                              'No Orders Yet'.tr(),
                              style: TextStyle(
                                color: Colors.grey.shade300,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    return ListView(
                      padding: EdgeInsets.only(bottom: 200),
                      children:
                          orders.data.map((e) => OrderCard(order: e)).toList(),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }),
      ),
    );
  }
}

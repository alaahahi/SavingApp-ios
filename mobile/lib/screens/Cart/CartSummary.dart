import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'LabelValue.dart';

class CartSummary extends StatefulWidget {
  const CartSummary({
    Key key,
    @required this.total,
    @required this.saving,
    @required this.subTotal,
    this.onCheckout,
  }) : super(key: key);

  final int subTotal;
  final int saving;
  final int total;
  final void Function(void Function(bool)) onCheckout;

  @override
  _CartSummaryState createState() => _CartSummaryState();
}

class _CartSummaryState extends State<CartSummary> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      // margin: EdgeInsets.all(20),
      padding: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LabelValue(
            label: 'Subtotal'.tr(),
            value: widget.subTotal,
            color: Colors.teal.shade100,
          ),
          LabelValue(
            label: 'Saving'.tr(),
            value: -widget.saving,
            color: Colors.green.shade400,
          ),
          Divider(color: Colors.grey.shade200),
          LabelValue(
            label: 'Total'.tr(),
            value: widget.total,
            color: Colors.purple,
            extraSize: true,
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: () =>
                widget.onCheckout((bool v) => setState(() => loading = v)),
            child: loading
                ? Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.green.shade600)),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_outlined),
                      SizedBox(width: 10),
                      Text('Checkout'.tr()),
                    ],
                  ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(20),
              backgroundColor: Colors.green.shade50,
              primary: Colors.green,
              textStyle: TextStyle(
                // color: Colors.purple,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

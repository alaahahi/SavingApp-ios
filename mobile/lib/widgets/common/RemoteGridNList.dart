import 'package:coupons/widgets/Items/DisplayMode.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RemoteGridNList<T> extends StatelessWidget {
  RemoteGridNList({
    Key key,
    @required this.displayMode,
    @required this.future,
    @required this.filler,
  }) : super(key: key);

  final DisplayMode displayMode;
  final Future<List<T>> future;
  final Widget Function(T, bool) filler;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return renderIconTextMessage(
            Icons.error_outline,
            'Something does not add up'.tr() +
                '\n' +
                'Please try again later'.tr(),
          );
        }
        if (snapshot.hasData && snapshot.data.length > 0) {
          List<Widget> items = snapshot.data
              .map<Widget>((x) => filler(x, displayMode == DisplayMode.grid))
              .toList();

          if (displayMode == DisplayMode.list)
            return Column(children: items);
          else {
            final List<Widget> itemsOdd = [];
            final List<Widget> itemsEven = [];

            for (var i = 0; i < items.length; i++) {
              if (i % 2 == 0) {
                itemsOdd.add(items[i]);
              } else {
                itemsEven.add(items[i]);
              }
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(children: itemsOdd),
                Column(children: itemsEven),
              ],
            );
          }
        }
        return renderIconTextMessage(
          Icons.warning_amber_outlined,
          'Nothing found here'.tr(),
        );
      },
    );
  }

  Padding renderIconTextMessage(IconData icon, String msg) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 100,
            color: Colors.grey.shade300,
          ),
          SizedBox(height: 20),
          Text(
            msg,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade300,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

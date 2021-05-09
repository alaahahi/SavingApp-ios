import 'package:cached_network_image/cached_network_image.dart';
import 'package:coupons/models/OrderModel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({Key key, this.order}) : super(key: key);

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 10),
      elevation: 10,
      child: Container(
//        height: MediaQuery.of(context).size.height / 4.4,
        margin: EdgeInsets.all(1),
        child: Column(
          children: [
            ...order.product
                .map(
                  (e) => Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Tags(
                            //اذا كان هذا العنصر موجود لا تكرره
                            alignment: WrapAlignment.center,
                            itemCount: 1,
                            itemBuilder: (index) {
                              return ItemTags(
                                index: index,
                                title: order.orderTotal.toString(),
                                activeColor: Colors.red,
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                elevation: 0.0,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                textColor: Colors.white,
                                textActiveColor: Colors.white,
                                textOverflow: TextOverflow.ellipsis,
                              );
                            },
                          ),
                          Tags(
                            alignment: WrapAlignment.center,
                            itemCount: 1,
                            itemBuilder: (index) {
                              return ItemTags(
                                index: index,
                                title: (order.isAccepted == 0
                                    ? 'Wating'.tr()
                                    : order.isAccepted == 1
                                        ? 'Compleated'.tr()
                                        : order.isAccepted == 2
                                            ? 'Rejected'.tr()
                                            : 'contact admin'),
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                activeColor: order.isAccepted == 0
                                    ? Colors.blue
                                    : order.isAccepted == 1
                                        ? Colors.green
                                        : order.isAccepted == 2
                                            ? Colors.blueGrey
                                            : Colors.blueGrey,
//
                                elevation: 0.0,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                textOverflow: TextOverflow.ellipsis,
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: CachedNetworkImage(
                              imageUrl: e.photo,
//                        width: MediaQuery.of(context).size.width / 9,
//                        height: MediaQuery.of(context).size.height / 7,

//                              width: MediaQuery.of(context).size.width / 11,

                              height: MediaQuery.of(context).size.height / 5,
                              fit: BoxFit.fill,
                            ),
                          ),

//                          SizedBox(
//                            width: 16,
//                          ),

                          Container(
                            margin: EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(e.pivot.quantity.toString()),
                                    Text(' x '),
                                    Text(e.discountPrice.toString()),
                                  ],
                                ),
                                Container(
                                  width: 100,
                                  child: Text(
                                    e.titleTranslation,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.amber),
                                    textAlign: TextAlign.center,
                                    maxLines: 5,
//                              softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}

import 'package:coupons/widgets/Items/DisplayMode.dart';
import 'package:flutter/material.dart';

class ListActionBar extends StatelessWidget {
  const ListActionBar({
    Key key,
    @required this.displayMode,
    @required this.changeDisplayMode,
  }) : super(key: key);

  final DisplayMode displayMode;
  final Function(DisplayMode) changeDisplayMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          // TextButton(
          //   child: Icon(Icons.filter_list),
          //   onPressed: () {
          //     showModalBottomSheet(
          //       context: context,
          //       useRootNavigator: true,
          //       builder: (context) {
          //         return Container(
          //           color: Colors.white,
          //           child: ListView(
          //             padding: EdgeInsets.all(30),
          //             children: [
          //               Text('Filter by'.tr()),
          //               SizedBox(height: 20),
          //               RatingBar.builder(
          //                 initialRating: 0,
          //                 minRating: 0,
          //                 direction: Axis.horizontal,
          //                 allowHalfRating: true,
          //                 itemCount: 5,
          //                 itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          //                 itemBuilder: (context, _) => Icon(
          //                   Icons.star,
          //                   color: Colors.amber,
          //                 ),
          //                 onRatingUpdate: (rating) {
          //                 },
          //               ),
          //               ListTile(
          //                 title: Text('Open Only'.tr()),
          //                 onLongPress: () {},
          //               ),
          //               ListTile(
          //                 title: Text('All Items'.tr()),
          //                 onTap: () {},
          //               ),
          //             ],
          //           ),
          //         );
          //       },
          //     );
          //   },
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => changeDisplayMode(DisplayMode.list),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  decoration: BoxDecoration(
                    color:
                        displayMode == DisplayMode.list ? Colors.black : null,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.list,
                    color:
                        displayMode == DisplayMode.list ? Colors.white : null,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => changeDisplayMode(DisplayMode.grid),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  decoration: BoxDecoration(
                    color:
                        displayMode == DisplayMode.grid ? Colors.black : null,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.grid_view,
                    color:
                        displayMode == DisplayMode.grid ? Colors.white : null,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

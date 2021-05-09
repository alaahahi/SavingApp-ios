import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RowTitle extends StatelessWidget {
  const RowTitle({Key key, this.title, this.onClickedMore}) : super(key: key);

  final String title;
  final Function onClickedMore;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 30, 10, onClickedMore != null ? 0 : 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade400,
            ),
          ),
          if (onClickedMore != null)
            InkWell(
              onTap: onClickedMore,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: Text(
                  'See All'.tr(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

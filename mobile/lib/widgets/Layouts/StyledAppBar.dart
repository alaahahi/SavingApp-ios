import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StyledAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StyledAppBar({
    Key key,
    this.title,
    this.color,
    this.actions,
  }) : super(key: key);

  final String title;
  final Color color;

  final List<Widget> actions;

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color ?? Colors.grey.shade50,
      elevation: 0,
      actionsIconTheme: IconThemeData(color: Colors.black),
      iconTheme: IconThemeData(color: Colors.black),
      actions: actions,
      title: Container(
        padding: EdgeInsets.all(30),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'dmserif',
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

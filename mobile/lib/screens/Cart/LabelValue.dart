import 'package:flutter/material.dart';

class LabelValue extends StatelessWidget {
  const LabelValue(
      {Key key,
      @required this.label,
      @required this.value,
      this.color,
      this.extraSize = false})
      : super(key: key);

  final String label;
  final dynamic value;
  final Color color;
  final bool extraSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: extraSize ? 24 : 18,
              fontStyle: FontStyle.italic,
            ),
          ),
          Text(
            value.toString(),
            style: TextStyle(
              color: color ?? Colors.black,
              fontSize: extraSize ? 28 : 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/core/style/app_colors.dart';

class FilterCard extends StatelessWidget {
  FilterCard({required this.filter, this.enabled = false, Key? key})
      : super(key: key) {
    if (enabled)
      color = mainColor;
    else
      color = Color.fromARGB(255, 184, 184, 184);
  }
  String filter;
  bool enabled;
  late Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: color)),
      child: Text(
        filter,
        style: TextStyle(color: color),
      ),
    );
  }
}

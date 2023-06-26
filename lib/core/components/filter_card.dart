import 'package:flutter/material.dart';
import 'package:vewww/core/style/app_colors.dart';

class FilterCard extends StatelessWidget {
  FilterCard(
      {required this.filter,
      required this.onPress,
      this.enabled = false,
      Key? key})
      : super(key: key) {
    if (enabled) {
      color = mainColor;
    } else {
      color = const Color.fromARGB(255, 184, 184, 184);
    }
  }
  String filter;
  bool enabled;
  late Color color;
  Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){onPress();},
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: color)),
        child: Text(
          filter,
          style: TextStyle(color: color),
        ),
      ),
    );
  }
}

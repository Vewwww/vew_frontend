import 'package:flutter/material.dart';
import 'package:vewww/core/style/app_colors.dart';

Widget defaultButton({
  double width = double.infinity,
  double? height,
  double textSize = 18,
  Color background = const Color.fromRGBO(2, 113, 106, 1),
  Function? function,
  required String text,
  Color textColor = Colors.white,
  IconData? buttonIcon,
  Color iconColor = Colors.white,
}) {
  return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: background,
      ),
      child: Center(
          child: MaterialButton(
        onPressed: () {
          if (function != null) function();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (buttonIcon != null)
              Icon(
                buttonIcon,
                color: iconColor,
              ),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: textSize,
              ),
            ),
          ],
        ),
      )));
}

Widget homeButton({
  double width = double.infinity,
  double? height,
  double textSize = 18,
  Color background = const Color.fromARGB(255, 255, 255, 255),
  Function? function,
  required String text,
  Color textColor = const Color.fromRGBO(2, 113, 106, 1),
  IconData? buttonIcon,
  Color iconColor = Colors.white,
}) {
  return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: mainColor.withOpacity(0.5)),
        color: background,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(2, 2),
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(5, 0),
          ),
        ],
      ),
      child: Center(
          child: MaterialButton(
        onPressed: () {
          if (function != null) function();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (buttonIcon != null)
              Icon(
                buttonIcon,
                size: 30,
                color: const Color.fromRGBO(2, 113, 106, 1),
              ),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: textSize,
              ),
            ),
          ],
        ),
      )));
}

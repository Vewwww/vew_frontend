import 'package:flutter/material.dart';

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

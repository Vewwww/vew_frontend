import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  double? height,
  Color background = const Color.fromRGBO(2, 113, 106, 1),
  //TODO::make it required
  /*required*/ Function? function,
  required String text,
  Color textColor=Colors.white,
  IconData ? buttonIcon,
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
                if(buttonIcon != null)
                Icon(buttonIcon),
                Text(
                  text,
                  style: TextStyle(
                    color:textColor ,
                    fontSize: 20,
                  ),
                ),
              ],
        ),
      )));
}

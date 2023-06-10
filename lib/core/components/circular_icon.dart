import 'package:flutter/material.dart';

Widget CircularIcon({
  required title,
  double radius = 25,
  required Widget child,
}) {
  return Row(
    children: [
      CircleAvatar(
        backgroundColor: Color.fromRGBO(2, 113, 106, 1),
        radius: radius,
        child: child,
      ),
      const SizedBox(
        width: 15,
      ),
      Text(
        title,
        style: TextStyle(
          fontSize: 20,
        ),
      )
    ],
  );
}

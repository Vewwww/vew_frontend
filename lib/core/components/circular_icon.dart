import 'package:flutter/material.dart';

Widget circularIcon({
  required title,
  double radius = 20,
  required Widget child,
}) {
  return Row(
    children: [
      CircleAvatar(
        backgroundColor: const Color.fromRGBO(2, 113, 106, 1),
        radius: radius,
        child: child,
      ),
      const SizedBox(
        width: 10,
      ),
      Text(
        title,
        style: const TextStyle(
          fontSize: 15,
        ),
      )
    ],
  );
}

import 'package:flutter/material.dart';

Widget backwardArrow({
  required Function() function,
  Color iconColor = const Color.fromRGBO(2, 113, 106, 1),
}) {
  return IconButton(
    onPressed: function,
    iconSize: 40,
    color: iconColor,
    icon: const Icon(
      Icons.keyboard_arrow_left,
    ),
  );
}

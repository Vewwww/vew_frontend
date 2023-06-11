import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import '../style/app_colors.dart';

Widget BackwardArrow({
  required Function() function,
  Color iconColor = const Color.fromRGBO(2, 113, 106, 1),
}) {
  return IconButton(
    onPressed: function,
    iconSize: 40,
    color: iconColor,
    icon: Icon(
      Icons.keyboard_arrow_left,
    ),
  );
}

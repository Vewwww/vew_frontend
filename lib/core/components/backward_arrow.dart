import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import '../style/app_colors.dart';

Widget BackwardArrow({
  required Function() function,
  Color? iconColor, 
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

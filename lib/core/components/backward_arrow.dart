import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

Widget BackwardArrow({
  required Function() function,
}) {
  return IconButton(
    onPressed: function,
    iconSize: 40,
    color: Color.fromRGBO(2, 113, 106, 1),
    icon: Icon(
      Icons.keyboard_arrow_left,
    ),
  );
}

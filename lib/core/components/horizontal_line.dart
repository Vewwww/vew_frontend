import 'package:flutter/material.dart';

Widget horizontalLine({double height = 2.0, double width = double.infinity}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 7.0),
    child: Container(
      height: height,
      width: width,
      color: Colors.grey,
    ),
  );
}

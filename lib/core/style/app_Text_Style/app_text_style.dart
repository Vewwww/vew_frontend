import 'package:flutter/material.dart';
import 'package:vewww/core/style/app_colors.dart';

class AppTextStyle {
  static TextStyle mainStyle({double size = 18}) =>
      TextStyle(color: mainColor, fontSize: size);
  static TextStyle greyStyle({double size = 18}) =>
      TextStyle(color: Color.fromARGB(255, 190, 190, 190), fontSize: size);
  static TextStyle darkGreyStyle({double size = 18}) =>
      TextStyle(color: Color.fromARGB(255, 115, 115, 115), fontSize: size);
  static TextStyle boldStyle({double size = 18}) => TextStyle(
      color: Colors.black, fontSize: size, fontWeight: FontWeight.bold);
  static TextStyle whiteTextStyle(double size) => TextStyle(
      color: Colors.white, fontSize: size, fontWeight: FontWeight.w400);
  static TextStyle logoTextStyle(double size,
          {Color color = const Color.fromARGB(255, 2, 113, 106)}) =>
      TextStyle(
        color: color,
        fontFamily: "Shrikhand",
        fontSize: size,
      );

  static titleTextStyle(double size) => TextStyle(
      color: const Color.fromARGB(255, 2, 113, 106),
      fontSize: size,
      fontWeight: FontWeight.w400);
}

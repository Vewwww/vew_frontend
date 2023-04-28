import 'package:flutter/material.dart';
import 'package:vewww/core/style/app_colors.dart';

class AppTextStyle {
  static TextStyle mainStyle({double size = 18}) =>
      TextStyle(color: mainColor, fontSize: size);
  static TextStyle greyStyle({double size = 18}) =>
      TextStyle(color: Color.fromARGB(255, 190, 190, 190), fontSize: size);
  static TextStyle darkGreyStyle({double size = 18}) =>
      TextStyle(color: Colors.grey, fontSize: size);
  static TextStyle boldStyle({double size = 18}) => TextStyle(
      color: Colors.black, fontSize: size, fontWeight: FontWeight.bold);
}

import 'package:flutter/material.dart';
import 'package:vewww/core/style/app_colors.dart';
import '../style/app_Text_Style/app_text_style.dart';

Widget serviceCard({
  required Function() function,
  required String title,
  bool isSelected = false,
}) {
  return GestureDetector(
    onTap: function,
    child: Container(
      margin: const EdgeInsets.all(10),
      height: 70,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: mainColor),
        color: (isSelected) ? mainColor : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(2, 2),
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(5, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
            child: Text(
          title,
          textAlign: TextAlign.center,
          style: (isSelected)
              ? AppTextStyle.whiteTextStyle(20)
              : AppTextStyle.mainStyle(size: 20),
        )),
      ),
    ),
  );
}

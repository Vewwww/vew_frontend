import 'package:flutter/material.dart';
import '../style/app_colors.dart';
import '../style/app_text_style/app_text_style.dart';

class Logo extends StatelessWidget {
  Image? logo;
  Color? color;
  double? size;
  Logo({String? color, double? size , Key? key}):super(key: key) {
    if (size == null) {
      this.size = 10;
    } else {
      this.size = size;
    }
    if (color == null) {
      logo = Image.asset(
        "assets/images/Logo(1).png",
        width: size,
      );
      this.color = mainColor;
    } else {
      logo = Image.asset(
        "assets/images/White Logo.png",
        width: size,
      );
      this.color = Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        logo!,
        SizedBox(
          height: size! / 15,
        ),
        Text(
          "Vewww",
          style: AppTextStyle.logoTextStyle(size! / 7, color: color!),
        ),
      ],
    );
  }
}

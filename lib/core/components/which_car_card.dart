import 'package:flutter/material.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';

Widget whichCarCard({
  required Function() function,
  required String carType,
  required String carModel,
  required Color carColor,
}) {
  return InkWell(
    onTap: function,
    child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        width: double.infinity,
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 30,
                child: Icon(Icons.car_repair, color: carColor),
              ),
            ),
            Text(
              carType,
              style: AppTextStyle.darkGreyStyle(size: 17),
            ),
            Text(
              carModel,
              style: AppTextStyle.greyStyle(),
            ),
          ],
        )),
  );
}

import 'package:flutter/material.dart';
import 'package:vewww/core/components/rating_bar.dart';

import '../style/app_Text_Style/app_text_style.dart';
import '../style/app_colors.dart';
import 'default_button.dart';
import 'dart:math';
double roundDouble(double value, int places){ 
   num mod = pow(10.0, places); 
   return ((value * mod).round().toDouble() / mod); 
}

Widget nearestWinchCard({
  required String name,
  required String plateNumber,
  required double rate,
  required double distance,
  required Function() function,
}) {
  double roundedDistance= roundDouble(distance, 1);
  return InkWell(
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
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      width: double.infinity,
      child: Row(children: [
        Container(
          width: 130,
          height: 130,
          margin: const EdgeInsets.fromLTRB(16, 7, 0, 3),
          decoration: BoxDecoration(
              color: mainColor,
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: const Icon(
            Icons.car_repair,
            size: 50,
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: 7,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: AppTextStyle.darkGreyStyle(size: 15),
            ),
            Text(
              plateNumber,
              style: AppTextStyle.darkGreyStyle(size: 15),
            ),
            (rate!= null)
                    ? RatingBar(rate)
                    : Container(),
            Row(
              children: [
                Text(
                  'Far by: ',
                  style: AppTextStyle.darkGreyStyle(size: 15),
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
                Text(
                  "$roundedDistance km",
                )
              ],
            ),
            defaultButton(text: 'Request', width: 110, function: function),
          ],
        )
      ]),
    ));
}
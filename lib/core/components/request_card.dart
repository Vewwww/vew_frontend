import 'package:flutter/material.dart';
import 'package:vewww/core/components/rating_bar.dart';
import 'dart:math';

import '../style/app_Text_Style/app_text_style.dart';
import '../style/app_colors.dart';
import 'default_button.dart';

double roundDouble(double value, int places) {
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

Widget requestCard(
    {required bool isWinch,
    required String name,
    required double rate,
    String? thirdVal,
    required String requestState,
    double? distance,
    required Function() function}) {
  double? roundedDistance;
  if (distance != null) roundedDistance = roundDouble(distance, 1);
  return InkWell(
      child: Container(
    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    padding: const EdgeInsets.all(3),
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
        width: 100,
        height: 100,
        margin: const EdgeInsets.fromLTRB(16, 7, 0, 3),
        decoration: BoxDecoration(
            color: mainColor,
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: (isWinch)
            ? const Icon(
                Icons.car_repair,
                size: 50,
                color: Colors.white,
              )
            : const Icon(
                Icons.handyman_outlined,
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
          (thirdVal == null)
              ? Text(
                  isWinch ? "winch" : "mechanic",
                  style: AppTextStyle.darkGreyStyle(size: 15),
                )
              : Text(
                  thirdVal,
                  style: AppTextStyle.darkGreyStyle(size: 15),
                ),
          (rate != null)
              ? RatingBar(
                  rate,
                  size: 12,
                )
              : Container(),
          (distance != null)
              ? Row(
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
                )
              : Container(),
          Text(
            requestState,
            style: AppTextStyle.greyStyle(size: 15),
          ),
          SizedBox(
              height: 30,
              child: defaultButton(
                  text: 'Cancel', width: 100, function: function)),
        ],
      )
    ]),
  ));
}

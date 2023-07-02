import 'package:flutter/material.dart';
import 'package:vewww/core/components/rating_bar.dart';
import 'dart:math';

import '../style/app_Text_Style/app_text_style.dart';
import '../style/app_colors.dart';
import 'default_button.dart';

Widget requestCard({
  required bool isWinch,
  required String name,
  required double rate,
  required String thirdVal,
  required String requestState,
  required Function() function
}){
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
          child:(isWinch)? const Icon(
            Icons.car_repair,
            size: 50,
            color: Colors.white,
          ):const Icon(
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
            Text(
              thirdVal,
              style: AppTextStyle.darkGreyStyle(size: 15),
            ),
            (rate!= null)
                    ? RatingBar(rate)
                    : Container(),
            Text(requestState, style: AppTextStyle.greyStyle(size:15),),
            defaultButton(text: 'Cancel', width: 110, function: function),
          ],
        )
      ]),
    ));

}
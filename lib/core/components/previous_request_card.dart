import 'package:flutter/material.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';

import '../style/app_colors.dart';

Widget previousRequestCard({
   bool isWinch = true,
   required String location,
   required String dateTime,
   required String serviceProvider,
   required Function() function
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
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      width: double.infinity,
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.fromLTRB(16, 7, 0, 3),
            decoration: BoxDecoration(
                color: mainColor,
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: (isWinch)? const Icon(
              Icons.car_repair,
              size: 50,
              color: Colors.white,
            ):const Icon(
              Icons.handyman_outlined,
              size: 50,
              color: Colors.white,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Location: ', style: AppTextStyle.greyStyle(size: 15),),
                  Text(location, style: AppTextStyle.darkGreyStyle(size: 15))
                ],
              ),
              Row(
                children: [
                  Text('Date and Time: ', style: AppTextStyle.greyStyle(size: 15),),
                  Text(dateTime, style: AppTextStyle.darkGreyStyle(size: 15))
                ],
              ),
              Row(
                children: [
                  Text('Accepted by: ', style: AppTextStyle.greyStyle(size: 15),),
                  Text(serviceProvider, style: AppTextStyle.darkGreyStyle(size: 15))
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

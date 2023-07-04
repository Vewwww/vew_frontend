import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';

Widget whichCarCard(
  {
    required Function() function,
    required String carType,
    required String carModel,
  }
){
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
      //TODO: Icon of car with color
      child: Column(children: [
        Text(carType, style: AppTextStyle.darkGreyStyle(size: 17),),
        Text(carModel, style: AppTextStyle.greyStyle(),),
      ],)
    ),
  );
}
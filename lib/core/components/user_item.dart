import 'package:flutter/material.dart';

import '../style/app_Text_Style/app_text_style.dart';

Widget userItem({
  required String title,
  required String subtitle,
  required Function() function,
}){
return  Container(
      height: 70,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style:AppTextStyle.darkGreyStyle(size: 20) , ),
            Text(subtitle, style:AppTextStyle.greyStyle() , ),
          ],
        ),
      ),
      );
}
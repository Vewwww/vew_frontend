import 'package:flutter/material.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/core/style/app_colors.dart';

Widget uaserCard({ 
  required Function() function,
  required String title,
  required IconData? icon,
  }){
  return GestureDetector(
    onTap: function,
    child: Container(
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
        child: Row(children: [
          Icon(icon, color: mainColor, size: 25,),
          SizedBox(width: 30,),
          Text(title, style: AppTextStyle.mainStyle(size: 20),),
        ],),
      ),
      ),
    );
}
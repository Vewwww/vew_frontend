import 'package:flutter/material.dart';
import 'package:vewww/core/components/default_button.dart';
import 'package:vewww/core/components/rating_bar.dart';

import '../style/app_Text_Style/app_text_style.dart';
import '../style/app_colors.dart';

Widget nearByCard({
  required IconData? icon,
  required String title,
  required double rating,

}){
  return GestureDetector(
      onTap: () {
        //goes to MC or GS profile
      },
      child: Container(
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
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              backgroundColor: mainColor.withOpacity(0.6),
              child:  Icon(
                icon,
                color: Colors.white,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.mainStyle(size: 20),
                ),
                const SizedBox(height: 5),
                RatingBar(rating),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    defaultButton(text: 'Request Winch', height: 40, width: 120,textSize: 12 ),
                    IconButton(onPressed: (){}, icon: Icon(Icons.phone, color: mainColor,),),
                    IconButton(onPressed: (){}, icon: Icon(Icons.location_on_outlined, color: mainColor,),),
                  ],
                ),
                
              ],
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
}
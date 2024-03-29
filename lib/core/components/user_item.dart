import 'package:flutter/material.dart';
import 'package:vewww/core/style/app_colors.dart';

import '../style/app_Text_Style/app_text_style.dart';

Widget userItem({
  required String title,
  required String subtitle,
  required Function() function,
  required IconData icon,
}) {
  return Container(
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
      child: GestureDetector(
        onTap: function,
        child: Row(
          children: [
             Icon(
              icon,
              color: mainColor,
              size: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    title,
                    style: AppTextStyle.darkGreyStyle(size: 20),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  child: Text(
                    subtitle,
                    style: AppTextStyle.greyStyle(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),                
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

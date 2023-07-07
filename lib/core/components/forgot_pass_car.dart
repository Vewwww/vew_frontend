import 'package:flutter/material.dart';
import '../style/app_Text_Style/app_text_style.dart';

Widget forgotPassCard({
  required String title,
  required String content,
  required IconData icon,
}){
  return Container(
              color: Colors.grey.shade100,
              width: 350,
              height: 70,

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      color: const Color.fromRGBO(2, 113, 106, 1),
                      size: 40,
                    ),
                    const SizedBox(width: 15,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                        style: AppTextStyle.darkGreyStyle(size: 18),
                        ),
                        Text(content,
                        style: AppTextStyle.boldStyle(size: 20),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
}
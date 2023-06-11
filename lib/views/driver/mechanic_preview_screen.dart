import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/components/default_button.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/core/style/app_colors.dart';

import '../../core/components/rating_stars.dart';

class MechanicPreviewScreen extends StatelessWidget {
  const MechanicPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Column(children: [
        Expanded(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                CustomAppBar(
                  haveBackArrow: true,
                  backgroundcolor: mainColor,
                  iconColor: Colors.white,
                ),
                Image.asset(
                  'assets/images/shop.png',
                  height: 175,
                  width: 175,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Mechanic Workshop Name',
                  style: AppTextStyle.whiteTextStyle(20),
                ),
                SizedBox(
                  height: 15,
                ),
                ratingStars(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.phone, color: Colors.white, size: 30,), onPressed: () {  },
                    ),
                    SizedBox(width: 7,),
                     IconButton(
                      icon: Icon(Icons.location_on, color: Colors.white, size: 30,), onPressed: () {  },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.0),
                topLeft: Radius.circular(40.0),
              ),
              color: Colors.white,
            ),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                  'Services :',
                  style: AppTextStyle.mainStyle(size: 20),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Regular maintenance service',
                  style: AppTextStyle.darkGreyStyle(size: 17),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  'Change oil',
                  style: AppTextStyle.darkGreyStyle(size: 17),
                ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(height:15),
                defaultButton(text: 'Request Winch', width: 390),
                ],
            ),
          ),
        ),
      ]),
    );
  }
}

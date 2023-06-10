import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../core/components/custom_app_bar.dart';
import '../core/components/default_button.dart';
import '../core/components/rating_stars.dart';
import '../core/style/app_Text_Style/app_text_style.dart';
import '../core/style/app_colors.dart';

class GasStation extends StatelessWidget {
  const GasStation({super.key});

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
                CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/gasStation.webp',
                  ),
                  radius: 85,

                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Gas Station Name',
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                    'Address :',
                    style: AppTextStyle.mainStyle(size: 20),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    ' Al Manial، 37 El-Rawda Square, Al Manyal Al Gharbi, Old Cairo, Cairo Governorate',
                    style: AppTextStyle.darkGreyStyle(size: 17),
                  ),          
                    ],
                  ),
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
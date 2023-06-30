import 'package:flutter/material.dart';
import 'package:vewww/core/components/rating_bar.dart';

import '../style/app_Text_Style/app_text_style.dart';
import '../style/app_colors.dart';

Widget previousRequest(){

  return InkWell(
        onTap: () {
          // NavigationUtils.navigateTo(
          //     context: context,
          //     destinationScreen: SingleRequestScreen(
          //       type: "comming",
          //     ));
        },
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                width: 140,
                height: 140,
                margin: const EdgeInsets.fromLTRB(16, 7, 0, 3),
                decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: const Icon(
                  Icons.car_repair,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              SizedBox(width:5 ,),
                    Column(
                      children: [
                        Text(
                          "Winch driver\'s name",
                          style: AppTextStyle.titleTextStyle(20),
                        ),
                        // RatingBar(3.5, size: 15),
                        Text(
                          "Address of req",
                          style: AppTextStyle.darkGreyStyle(size: 13),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                            
                        //     ElevatedButton(
                        //         style: ElevatedButton.styleFrom(
                        //           backgroundColor: Colors.grey,
                        //         ),
                        //         onPressed: () {},
                        //         child: const Text(
                        //           "رفض",
                        //           style: TextStyle(color: Colors.white),
                        //         )),
                        //     ElevatedButton(
                        //         style: ElevatedButton.styleFrom(
                        //           backgroundColor: mainColor,
                        //         ),
                        //         onPressed: () {},
                        //         child: const Text(
                        //           "قبول",
                        //           style: TextStyle(color: Colors.white),
                        //         )),
                        //   ],
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              
            ],
          ),
        ));
}

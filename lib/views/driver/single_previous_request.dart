import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:vewww/bloc/evaluate_service_provider_cubit/evaluate_service_provider_cubit.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/components/default_button.dart';
import 'package:vewww/core/components/horizontal_line.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/core/style/app_colors.dart';

class SinglePreviousRequest extends StatelessWidget {
  SinglePreviousRequest(
      {super.key,
      required this.location,
      required this.dateTime,
      required this.carType,
      required this.serviceProviderName,
      required this.rating,
      required this.thirdInfo,
      required this.isWinch,
      required this.id,});
  String location;
  String dateTime;
  String carType;
  String serviceProviderName;
  double rating;
  String thirdInfo;
  bool isWinch;
  String id;

  @override
  Widget build(BuildContext context) {
    EvaluateServiceProviderCubit evaluateServiceProviderCubit = EvaluateServiceProviderCubit.get(context);
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            haveBackArrow: true,
            title: Text(
              'Previous Request',
              style: AppTextStyle.mainStyle(size: 25),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: mainColor,
                    child: (isWinch)
                        ? const Icon(
                            Icons.car_repair,
                            size: 50,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.handyman_outlined,
                            size: 50,
                            color: Colors.white,
                          ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Location: ',
                  style: AppTextStyle.mainStyle(size: 20),
                ),
                Text(
                  location,
                  style: AppTextStyle.darkGreyStyle(),
                ),
                SizedBox(
                  height: 10,
                ),
                HorizontalLine(),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Date and Time: ',
                  style: AppTextStyle.mainStyle(size: 20),
                ),
                Text(
                  dateTime,
                  style: AppTextStyle.darkGreyStyle(),
                ),
                SizedBox(
                  height: 10,
                ),
                HorizontalLine(),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Your car details: ',
                  style: AppTextStyle.mainStyle(size: 20),
                ),
                Text(
                  carType,
                  style: AppTextStyle.darkGreyStyle(),
                ),
                SizedBox(
                  height: 10,
                ),
                HorizontalLine(),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Service Provider: ',
                  style: AppTextStyle.mainStyle(size: 20),
                ),
                Text(
                  serviceProviderName,
                  style: AppTextStyle.darkGreyStyle(),
                ),
                Text(
                  'Rating: $rating',
                  style: AppTextStyle.darkGreyStyle(),
                ),
                //winch
                (isWinch)
                    ? Text(
                        'Plate Num:  $thirdInfo',
                        style: AppTextStyle.darkGreyStyle(),
                      )
                    : Text(
                        'Service:  $thirdInfo',
                        style: AppTextStyle.darkGreyStyle(),
                      ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    defaultButton(
                      text: 'Report',
                      width: 140,
                      function: () {
                        if(isWinch){
                          evaluateServiceProviderCubit.reportWinch(id);
                        }
                        else{
                          evaluateServiceProviderCubit.reportMechanic(id);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

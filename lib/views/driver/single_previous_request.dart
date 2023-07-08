import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:vewww/bloc/evaluate_service_provider_cubit/evaluate_service_provider_cubit.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/components/horizontal_line.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/core/utils/navigation.dart';
import 'package:vewww/views/driver/driver_home_screen.dart';

class SinglePreviousRequest extends StatelessWidget {
  SinglePreviousRequest({
    super.key,
    required this.location,
    required this.dateTime,
    required this.carType,
    required this.serviceProviderName,
    required this.rating,
    this.thirdInfo,
    required this.color,
    required this.isWinch,
    required this.repairerId,
    required this.id,
  });
  String location;
  String dateTime;
  String carType;
  Color color;
  String repairerId;
  String serviceProviderName;
  double rating;
  String? thirdInfo;
  bool isWinch;
  String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: mainColor,
                ),
                onPressed: () {
                  NavigationUtils.navigateAndClearStack(
                      context: context,
                      destinationScreen: const DriverHomeScreen());
                },
              ),
              title: Text(
                'Previous Request',
                style: AppTextStyle.mainStyle(),
              ),
              actions: [
                PopupMenuButton(
                    icon: const Icon(
                      Icons.menu,
                      color:  Color.fromRGBO(2, 113, 106, 1),
                      size: 30,
                    ),
                    itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 1,
                            height: 20,
                            child: Text("rate"),
                          ),
                          const PopupMenuItem(
                            value: 2,
                            height: 20,
                            child: Text("report"),
                          )
                        ],
                    offset: const Offset(10, 50),
                    color: Colors.white,
                    elevation: 0,
                    // on selected we show the dialog box
                    onSelected: (value) {
                      if (value == 1) {
                        _showRateDialog(context);
                      } else if (value == 2) {
                        _showReportDialog(context);
                      }
                    }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: (color == Colors.white)
                          ? mainColor
                          : const Color.fromARGB(255, 212, 239, 236),
                      child: (isWinch)
                          ? Icon(
                              Icons.car_repair,
                              size: 50,
                              color: color,
                            )
                          : Icon(
                              Icons.handyman_outlined,
                              size: 50,
                              color: color,
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Location ',
                    style: AppTextStyle.mainStyle(size: 20),
                  ),
                  Text(
                    location,
                    style: AppTextStyle.darkGreyStyle(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  horizontalLine(),
                  const SizedBox(
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
                  const SizedBox(
                    height: 10,
                  ),
                  horizontalLine(),
                  const SizedBox(
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
                  const SizedBox(
                    height: 10,
                  ),
                  horizontalLine(),
                  const SizedBox(
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
                          (thirdInfo == null) ? "" : 'Service:  $thirdInfo',
                          style: AppTextStyle.darkGreyStyle(),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        EvaluateServiceProviderCubit evaluateServiceProviderCubit =
            EvaluateServiceProviderCubit.get(context);
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: const EdgeInsets.only(top: 10.0),
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 260.0,
          ),
          title: const Center(
            child: Text(
              "Rate Repairer",
              textDirection: TextDirection.rtl,
            ),
          ),
          content: RatingBar.builder(
              itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
              onRatingUpdate: (val) {
                if (isWinch) {
                  evaluateServiceProviderCubit.rateWinch(repairerId, val);
                } else {
                  evaluateServiceProviderCubit.rateMechanic(
                      repairerId, val);
                }
              }),
          actions: [
            MaterialButton(
              child: Text(
                "Rate",
                style: AppTextStyle.darkGreyStyle(size: 12),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        EvaluateServiceProviderCubit evaluateServiceProviderCubit =
            EvaluateServiceProviderCubit.get(context);
        return SizedBox(
          height: 300,
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 260.0,
            ),
            title: Center(
              child: Text(
                "Report Repairer",
                textDirection: TextDirection.rtl,
                style: AppTextStyle.mainStyle(size: 15),
              ),
            ),
            content: RichText(
                text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "Are you sure you want to Report",
                  style: AppTextStyle.darkGreyStyle(size: 15),
                ),
                TextSpan(
                    text: "$serviceProviderName ?",
                    style: const TextStyle(color: Colors.red, fontSize: 18)),
              ],
            )),
            actions: [
              MaterialButton(
                child: Text(
                  "Report",
                  style: AppTextStyle.mainStyle(size: 12),
                ),
                onPressed: () {
                  if (isWinch) {
                    evaluateServiceProviderCubit.reportWinch(repairerId);
                  } else {
                    evaluateServiceProviderCubit
                        .reportMechanic(repairerId);
                  }
                  Navigator.of(context).pop();
                },
              ),
              MaterialButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:vewww/controllers/controller.dart';
import 'package:vewww/views/driver/which_car_screen.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/components/default_button.dart';
import '../../core/components/rating_bar.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/style/app_colors.dart';
import '../../core/utils/navigation.dart';
import '../../core/utils/sp_helper/cache_helper.dart';
import '../../model/repairer.dart';
import 'package:url_launcher/url_launcher.dart';

class MaintenanceCenterPreview extends StatelessWidget {
  MaintenanceCenterPreview({required this.maintenanceCenter, super.key});
  MaintenanceCenter maintenanceCenter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Column(children: [
        Expanded(
          child: SizedBox(
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
                  height: 150,
                  width: 150,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  (maintenanceCenter.name!.en) ?? maintenanceCenter.name!.ar!,
                  style: AppTextStyle.whiteTextStyle(20),
                ),
                const SizedBox(
                  height: 10,
                ),
                AppRatingBar(
                  maintenanceCenter.rate!,
                  size: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.phone,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () async {
                        if (maintenanceCenter.phoneNumber != null)
                          await Controller.call(maintenanceCenter.phoneNumber!);
                      },
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () async {
                          await Controller.goToGoogleMaps(
                              maintenanceCenter.location!);
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.0),
                topLeft: Radius.circular(40.0),
              ),
              color: Colors.white,
            ),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Car Types :',
                      style: AppTextStyle.mainStyle(size: 20),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: maintenanceCenter.carType!.length,
                        separatorBuilder: (context, int index) =>
                            const SizedBox(height: 3),
                        itemBuilder: (BuildContext context, int index) {
                          return Text(
                            maintenanceCenter.carType![index].name!.en!,
                            style: AppTextStyle.darkGreyStyle(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                defaultButton(
                    text: 'Request Winch',
                    width: 390,
                    function: () {
                      String id = SharedPreferencesHelper.getData(key: 'vewId');
                      NavigationUtils.navigateTo(
                          context: context,
                          destinationScreen: WhichCarScreen(
                            id: id,
                            isWinch: true,
                          ));
                    }),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

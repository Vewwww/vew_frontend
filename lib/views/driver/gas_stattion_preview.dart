import 'package:flutter/material.dart';
import 'package:vewww/controllers/controller.dart';
import 'package:vewww/core/utils/sp_helper/cache_helper.dart';
import 'package:vewww/views/driver/which_car_screen.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/components/default_button.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/style/app_colors.dart';
import '../../core/utils/navigation.dart';
import '../../model/repairer.dart';

class GasStationPreview extends StatelessWidget {
  GasStationPreview({required this.gasStation, super.key});
  GasStation gasStation;

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
                const CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/gasStation.webp',
                  ),
                  radius: 85,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  gasStation.name!.en ?? gasStation.name!.ar!,
                  style: AppTextStyle.whiteTextStyle(20),
                ),
                const SizedBox(
                  height: 10,
                ),
                // ratingStars(),
                IconButton(
                  icon: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    Controller.goToGoogleMaps(gasStation.location!);
                  },
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //   ],
                // )
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
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
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        gasStation.location!.description!.en!,
                        style: AppTextStyle.darkGreyStyle(size: 17),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(height: 15),
                defaultButton(text: 'Request Winch', width: 390,
                function: (){
                  String id=SharedPreferencesHelper.getData( key: 'vewId');
                        NavigationUtils.navigateTo(
                            context: context,
                            destinationScreen: WhichCarScreen(id: id,isWinch: true,));
                }
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

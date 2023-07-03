import 'package:flutter/material.dart';
import 'package:vewww/bloc/request_cubit/request_cubit.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/components/default_button.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/model/requests.dart';
import 'package:vewww/views/driver/requests_screen.dart';

import '../../controllers/controller.dart';
import '../../core/components/rating_bar.dart';
import '../../core/utils/sp_helper/cache_helper.dart';
import '../../model/repairer.dart' as repairer;

class MechanicPreviewScreen extends StatelessWidget {
  repairer.Mechanic mechanic;
  MechanicPreviewScreen({required this.mechanic, super.key});

  @override
  Widget build(BuildContext context) {
    RequestCubit requestCubit= RequestCubit.get(context);
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
                  height: 100,
                  width: 100,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  mechanic.name!.en ?? mechanic.name!.ar!,
                  style: AppTextStyle.whiteTextStyle(20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Owner : ${mechanic.ownerName!}",
                  style: AppTextStyle.greyStyle(size: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                RatingBar(mechanic.rate!),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.phone,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () async {
                        if (mechanic.phoneNumber != null)
                          await Controller.call(mechanic.phoneNumber!);
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
                          await Controller.goToGoogleMaps(mechanic.location!);
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
                      'Services:',
                      style: AppTextStyle.mainStyle(size: 20),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: mechanic.service!.length,
                        separatorBuilder: (context, int index) =>
                            const SizedBox(height: 3),
                        itemBuilder: (BuildContext context, int index) {
                          return Text(
                            mechanic.service![index].name!.en ??
                                mechanic.service![index].name!.ar!,
                            style: AppTextStyle.darkGreyStyle(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                (mechanic.hasDelivery == true)
                    ? defaultButton(
                        text: 'Request Mechanic',
                        width: 390,
                        function: () {
                          CreateRequest createRequest=CreateRequest(
                            driver: SharedPreferencesHelper.getData( key: 'vewId'),
                          car: '6484789db6fc5a39cbe4e3d8',
                          //location: await requestCubit.getLocation(),
                          mechanic: mechanic.sId,
                          //service:mechanic.service![index].name!.en, 
                          );
                          requestCubit.createMechanicRequest(createRequest);
                          if(requestCubit is CreateMechanicRequestSuccessState){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => RequestScreen(isWinch: false,))));
                          }else{
                            return CircularProgressIndicator();
                          }
                        },
                      )
                    : defaultButton(text: 'Request Winch', width: 390),
              ],
            ),
          ),
        )
      ]),
    );
  }
}

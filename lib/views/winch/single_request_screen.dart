import 'package:flutter/material.dart';
import 'package:vewww/core/components/backward_arrow.dart';
import 'package:vewww/core/components/rating_bar.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/core/utils/sp_helper/cache_helper.dart';
import 'package:vewww/views/mechanic/mechanic_home_screen.dart';
import 'package:vewww/views/winch/winch_home_page.dart';

import '../../bloc/repairer_requests_cubit.dart/repairer_requests_cubit.dart';
import '../../core/components/data_element.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/utils/navigation.dart';
import '../../model/accepted_requests_response.dart';

class SingleRequestScreen extends StatelessWidget {
  String type; // accepted or comming
  MechanicRequestsData acceptedRequestsData;
  SingleRequestScreen(this.acceptedRequestsData,
      {this.type = "accepted", Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                tileMode: TileMode.repeated,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  mainColor,
                  mainColor.withOpacity(0.8),
                  const Color.fromARGB(200, 4, 237, 222),
                  const Color.fromARGB(200, 4, 237, 222),
                  Colors.white
                ]),
          ),
          child: Stack(children: [
            SizedBox(
              width: double.infinity,
              child: Center(
                child: Column(children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                  ),
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Color.fromARGB(255, 2, 113, 106),
                    ),
                  ),
                  Text(
                    acceptedRequestsData.driver!.person!.name!,
                    style: AppTextStyle.whiteTextStyle(28),
                  ),
                ]),
              ),
            ),
            Positioned(
                top: 20,
                child: BackwardArrow(
                    function: () {
                      NavigationUtils.navigateBack(context: context);
                    },
                    iconColor: Colors.white)),
            Positioned(
              top: 20,
              right: 20,
              child: PopupMenuButton(
                  icon: const Icon(
                    Icons.menu,
                    size: 30,
                  ),
                  itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 1,
                          height: 20,
                          child: Text("ابلاغ"),
                        )
                      ],
                  offset: const Offset(10, 50),
                  color: Colors.white,
                  elevation: 0,
                  // on selected we show the dialog box
                  onSelected: (value) {
                    _showDialog(context);
                  }),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 2 * MediaQuery.of(context).size.height / 3 + 30,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                          Text("السيارة",
                              style: AppTextStyle.lightGrayTextStyle(14)),
                          DataElement("رقم السيارة",
                              acceptedRequestsData.car!.plateNumber!),
                          DataElement("نوع السيارة",
                              acceptedRequestsData.car!.carType!.name!.ar!),
                          (acceptedRequestsData.car!.carModel != null)
                              ? DataElement("موديل السيارة",
                                  acceptedRequestsData.car!.carModel!.name!)
                              : Container(),
                          DataElement("لون السيارة", "أحمر"),
                          DataElement("مشكلة السيارة",
                              acceptedRequestsData.service!.name!.ar!),
                          (acceptedRequestsData.location!.description!.ar !=
                                  "no arabic location description available")
                              ? DataElement(
                                  "الموقع",
                                  acceptedRequestsData
                                      .location!.description!.ar!)
                              : Container(),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () async {
                                  RepairerRequestsCubit repairerRequestsCubit =
                                      RepairerRequestsCubit.get(context);
                                  String role = SharedPreferencesHelper.getData(
                                      key: "vewRole");
                                  if (role == "winch") {
                                    NavigationUtils.navigateTo(
                                        context: context,
                                        destinationScreen: WinchHomePage());
                                  } else {
                                    if (type == "accepted") {
                                      await repairerRequestsCubit
                                          .mechanicCompleteRequest(
                                              acceptedRequestsData.sId!);
                                    } else {
                                      await repairerRequestsCubit
                                          .mechanicAcceptRequest(
                                              acceptedRequestsData.sId!);
                                    }

                                    NavigationUtils.navigateTo(
                                        context: context,
                                        destinationScreen:
                                            MechanicHomeScreen());
                                  }
                                },
                                child:
                                    Text((type == "accepted") ? "تم" : "قبول")),
                          ),
                          (type == "comming")
                              ? SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Color.fromARGB(
                                              255, 220, 220, 220)),
                                      onPressed: () async {
                                        RepairerRequestsCubit
                                            repairerRequestsCubit =
                                            RepairerRequestsCubit.get(context);
                                        String role =
                                            SharedPreferencesHelper.getData(
                                                key: "vewRole");
                                        if (role == "mechanic") {
                                          await repairerRequestsCubit
                                              .mechanicCancelRequest(
                                                  acceptedRequestsData.sId!);
                                        } else {
                                          NavigationUtils.navigateAndClearStack(
                                              context: context,
                                              destinationScreen:
                                                  WinchHomePage());
                                        }
                                      },
                                      child: Text(
                                        "رفض",
                                        style: AppTextStyle.mainStyle(),
                                      )),
                                )
                              : Container()
                        ]))))
          ])),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
              "تحرير ابلاغ",
              textDirection: TextDirection.rtl,
            ),
          ),
          content: Column(
            children: const [
              Text("هل انت متأكد انك تريد الابلاغ عن "),
              Text(
                "احمد كمال ؟",
                style: TextStyle(color: Colors.red),
              )
            ],
          ),
          actions: [
            MaterialButton(
              child: Text(
                "ابلاغ",
                style: AppTextStyle.darkGreyStyle(size: 12),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              child: const Text("الغاء"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/components/rating_bar.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/views/winch/winch_home_page.dart';

import '../../core/components/backward_arrow.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/utils/navigation.dart';
import 'winch_edit_profile_screen.dart';

class WinchProfile extends StatelessWidget {
  const WinchProfile({Key? key}) : super(key: key);

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
                    const SizedBox(height: 20),
                    Row(children: [
                      BackwardArrow(
                          iconColor: Colors.white,
                          function: () {
                            NavigationUtils.navigateAndClearStack(
                                context: context,
                                destinationScreen: WinchHomePage());
                          })
                    ]),
                    const SizedBox(height: 10),
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
                      "أحمد ناصر",
                      style: AppTextStyle.whiteTextStyle(28),
                    ),
                    RatingBar(
                      3.2,
                      size: 20,
                    ),
                  ]),
                ),
              ),
              Positioned(
                  bottom: 0,
                  child: Stack(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 2 * MediaQuery.of(context).size.height / 3,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20))),
                          child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                dataElement("الايميل", "example@gmail.com"),
                                dataElement("رقم الهاتف", "011111111"),
                                const Divider(
                                    color: Colors.grey, thickness: 0.8),
                                Text("السيارة",
                                    style: AppTextStyle.lightGrayTextStyle(14)),
                                dataElement("نوع السيارة", "KIA"),
                                dataElement("موديل السيارة", "camry"),
                                dataElement("رقم السيارة", "286 أ خ د"),
                                dataElement("لون السيارة", "أحمر"),
                              ]))),
                      Positioned(
                          child: Container(
                        height: 30,
                        width: 40,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: mainColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: IconButton(
                            onPressed: () {
                              NavigationUtils.navigateTo(
                                  context: context,
                                  destinationScreen: WinchEditProfileScreen());
                            },
                            icon: Icon(Icons.edit_outlined,
                                color: mainColor, size: 15)),
                      ))
                    ],
                  ))
            ])));
  }

  Widget dataElement(String label, String data) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            label,
            style: AppTextStyle.titleTextStyle(15),
          ),
          const SizedBox(height: 2),
          Text(
            data,
            style: AppTextStyle.darkGreyStyle(size: 14),
          ),
          Divider(
            color: mainColor,
            thickness: 0.8,
          )
        ],
      ),
    );
  }
}

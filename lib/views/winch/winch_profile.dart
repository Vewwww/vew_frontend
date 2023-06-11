import 'package:flutter/material.dart';
import 'package:vewww/core/style/app_colors.dart';

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
                      "أحمد ناصر",
                      style: AppTextStyle.whiteTextStyle(28),
                    ),
                    Image.asset(
                      "assets/images/rating.png",
                      width: 120,
                      fit: BoxFit.cover,
                    )
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
                          padding: EdgeInsets.symmetric(
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
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: mainColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: IconButton(
                            onPressed: () {
                              NavigationUtils.navigateTo(
                                  context: context,
                                  destinationScreen: WinchEditProfileScreen());
                            },
                            icon: Icon(Icons.edit_outlined,
                                color: mainColor)),
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

import 'package:flutter/material.dart';
import 'package:vewww/core/style/app_colors.dart';

import '../../core/components/data_element.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/utils/navigation.dart';

class SingleRequestScreen extends StatelessWidget {
  const SingleRequestScreen({Key? key}) : super(key: key);

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
              top: 40,
              child: PopupMenuButton(
                  icon: const Icon(
                    Icons.menu,
                    size: 40,
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
                    height: 2 * MediaQuery.of(context).size.height / 3,
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
                          DataElement("رقم السيارة", "286 أ خ د"),
                          DataElement("نوع السيارة", "KIA"),
                          DataElement("موديل السيارة", "camry"),
                          DataElement("لون السيارة", "أحمر"),
                          DataElement("مشكلة السيارة", "تغيير السيارة"),
                          DataElement("الموقع", "أحمد مراد، جيزة، مصر"),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  NavigationUtils.navigateBack(
                                      context: context);
                                },
                                child: const Text("تم")),
                          )
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

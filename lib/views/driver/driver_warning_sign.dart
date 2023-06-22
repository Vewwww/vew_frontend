import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../core/components/a_warning_sign.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../common/single_warning_sign_screen.dart';

class DriverWarningSign extends StatelessWidget {
  const DriverWarningSign({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomAppBar(
            title: Text(
              'Warning Signs',
              style: AppTextStyle.mainStyle(size: 25),
            ),
            haveBackArrow: true,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => aWarningSign(
                    title: 'Check Engine',
                    imageURL:
                        'https://hips.hearstapps.com/hmg-prod/images/check-engine-light-icon-1616189100.jpg',
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  SingleWarningSignScreen())));
                    }),
                itemCount: 15,
                separatorBuilder: (context, index) => SizedBox(
                  height: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
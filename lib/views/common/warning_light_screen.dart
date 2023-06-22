import 'package:flutter/material.dart';
import 'package:vewww/core/components/a_warning_sign.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/views/admin/add_warning_sign_screen.dart';
import 'package:vewww/views/common/single_warning_sign_screen.dart';

import '../../core/components/add_button.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';

class WarningLightScreen extends StatelessWidget {
  const WarningLightScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: addButton(function: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddWarningSignScreen()));
      }),
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
                                  const SingleWarningSignScreen())));
                    }),
                itemCount: 15,
                separatorBuilder: (context, index) => const SizedBox(
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

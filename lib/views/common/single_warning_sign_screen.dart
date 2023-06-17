import 'package:flutter/material.dart';
import 'package:vewww/core/components/horizontal_line.dart';

import '../../core/components/backward_arrow.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';

class SingleWarningSignScreen extends StatelessWidget {
  const SingleWarningSignScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(title: Text('Check Engine', style: AppTextStyle.mainStyle(size: 25),), haveBackArrow: true,),
            Center(
              child: Image.network(
                'https://hips.hearstapps.com/hmg-prod/images/check-engine-light-icon-1616189100.jpg',
                height: 150,
                width: 150,
              ),
            ),
            Text(
              'Description: ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Indicator light turns on whenever the engine is turned on to check the bulb. If the light stays illuminated, the car’s diagnostic systems have detected a malfunction that needs to be investigated.',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            HorizontalLine(),
            SizedBox(
              height: 10,
            ),
            Text(
              'Solution: ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Indicator light turns on whenever the engine is turned on to check the bulb. If the light stays illuminated, the car’s diagnostic systems have detected a malfunction that needs to be investigated.',
              style: TextStyle(
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/components/default_button.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/views/request_winch_screen.dart';

import '../core/utils/navigation.dart';

class WinchOnTheWayScreen extends StatelessWidget {
  const WinchOnTheWayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //appBar 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border.all(
                      color: Color.fromRGBO(2, 113, 106, 1), width: 2)),
              child: Padding(
                padding: const EdgeInsets.all(.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Mohammed',
                              style: TextStyle(
                                color: Color.fromRGBO(2, 113, 106, 1),
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 7.5,
                            ),
                            Text(
                              'is on his way',
                              style: AppTextStyle.boldStyle(size: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              'Plate Number: ',
                              style: AppTextStyle.boldStyle(),
                            ),
                            Text(
                              'ا ق 1 2 4 5',
                              style: AppTextStyle.darkGreyStyle(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              'Rate: ',
                              style: AppTextStyle.boldStyle(),
                            ),
                            Text(
                              '4.5',
                              style: AppTextStyle.darkGreyStyle(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        defaultButton(text: 'Call', width: 100),
                        defaultButton(text: 'Chat', width: 100)
                      ],
                    )
                  ],
                ),
              ),
            ),
            defaultButton(text: 'Cancel Request', width: 350,
            function: (){
              NavigationUtils.navigateTo(
                      context: context, destinationScreen: RequestWinchScreen());
            }
            
            ),
          ],
        ),
      ),
    );
  }
}

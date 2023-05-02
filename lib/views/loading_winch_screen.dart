import 'package:flutter/material.dart';
import 'package:vewww/core/components/default_button.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';

class LoadingWinchScreen extends StatelessWidget {
  const LoadingWinchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Center(
            child: Image.asset(
          'assets/images/Logo.png',
          height: 110,
          width: 110,
        )),
      ),
      body: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Image.asset(
            'assets/images/loader.gif',
            height: 200,
            width: 200,
          ),
          Column(
            children: [
              Text(
                'Please Wait.... ',
                style: AppTextStyle.darkGreyStyle(size: 20),
              ),
              SizedBox(height: 15,),
              Text(
                'Finding the nearest winch',
                style: AppTextStyle.darkGreyStyle(size: 20),
              ),
            ],
          ),
          defaultButton(text: 'Cancel', width: 300, function: () {}),
        ]),
      ),
    );
  }
}

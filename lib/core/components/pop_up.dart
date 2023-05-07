import 'package:flutter/material.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/views/sign_in_screen.dart';

Widget popUp(BuildContext context, {required String titleOFPopUp}) {
  return new AlertDialog(
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'assets/images/done.png',
          height: 150,
          width: 150,
        ),
        SizedBox(height: 10,),
        Text(
      titleOFPopUp,
      style: AppTextStyle.greyStyle(size: 17),
    ),
      ],
    ),
    actions: <Widget>[
      TextButton(
        child:  Text(
          'Cancel',
          style: AppTextStyle.mainStyle(size: 15),
        ),
        onPressed: () {
           Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()),
                          );
        },
      ),
    ],
  );
}

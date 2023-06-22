import 'package:flutter/material.dart';
import 'package:vewww/core/components/rating_stars.dart';

import '../style/app_Text_Style/app_text_style.dart';

Widget ratingPopUp(BuildContext context, {required String titleOFPopUp}){
return new AlertDialog(
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
      titleOFPopUp,
      style: AppTextStyle.greyStyle(size: 17),
    ),
    ratingStars(readOnly: false),
      ],
    ),
    actions: <Widget>[
      TextButton(
        child:  Text(
          'Submit',
          style: AppTextStyle.mainStyle(size: 15),
        ),
        onPressed: () {
          //  Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                       builder: (context) => SignInScreen()),
          //                 );
        },
      ),
    ],
  );

}
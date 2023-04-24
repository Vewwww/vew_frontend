import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vewww/views/single_warning_sign_screen.dart';

Widget aWarningSign({
  required String title,
  required String imageURL,
  required Function() function,
}){
  return GestureDetector(
    onTap: function,
    child: Container(
                decoration: BoxDecoration(
                  color:Colors.grey.shade200,
                  ),
                child: Row(
                  children: [
                    Image.network(imageURL,
                    height: 60,
                    width: 60,
                    ),
                    SizedBox(width: 15,),
                    Text(
                      title,
                      style: TextStyle(fontSize: 17),
                      )
                  ],
                ),
              ),
  );
}
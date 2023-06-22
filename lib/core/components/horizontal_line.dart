import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget HorizontalLine(
  {
    double height = 2.0,
    double width = double.infinity
  }){
  return Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.0),
            child: Container(
              height: height,
              width: width,
              color: Colors.grey,
            ),
          );
}
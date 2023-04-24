import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  double? height,
  Color background = const Color.fromRGBO(2, 113, 106, 1),
  /*required*/ Function()? function,
  required String text,
}) {
  return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color:  background,
          ),
        child: Center(
            child: MaterialButton(
          onPressed: function ,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        )));
}

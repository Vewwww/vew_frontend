import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget circularIcon({
  double radius = 25,
  required Widget child,
  
}){
  return CircleAvatar(
                backgroundColor: Color.fromRGBO(2, 113, 106, 1),
                radius: radius,
                child: child,
              );
}
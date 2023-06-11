import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget viewItem({
  required String name,
  required String address,
})=>
  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                  style: TextStyle(
                    fontSize: 20,
                    
                  ),
                  ),
                  Text(address,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                  ),
                  Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 7, 0),
              child: Container(
                height: 2.0,
                color: Colors.grey[300],
              ),
            ),
                ],
              );

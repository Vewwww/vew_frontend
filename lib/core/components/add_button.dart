import 'package:flutter/material.dart';

import '../style/app_colors.dart';

Widget addButton({
  required Function() function,
})=> FloatingActionButton(
          backgroundColor: mainColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 50,
          ),
          onPressed: function,
          );

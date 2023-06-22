import 'package:flutter/material.dart';
import 'package:vewww/core/style/app_colors.dart';

import '../style/app_text_style/app_text_style.dart';

class DataElement extends StatelessWidget {
  DataElement(this.label, this.data, {Key? key}) : super(key: key);
  String label;
  String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            label,
            style: AppTextStyle.titleTextStyle(15),
          ),
          const SizedBox(height: 2),
          Text(
            data,
            style: AppTextStyle.darkGreyStyle(size:14),
          ),
          Divider(
            color: mainColor,
            thickness: 0.8,
          )
        ],
      ),
    );
  }
}

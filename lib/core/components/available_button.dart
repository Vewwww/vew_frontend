import 'package:flutter/material.dart';
import 'package:vewww/core/style/app_colors.dart';

class AvailableButton extends StatefulWidget {
  const AvailableButton({Key? key}) : super(key: key);

  @override
  State<AvailableButton> createState() => _AvailableButtonState();
}
class _AvailableButtonState extends State<AvailableButton> {
  bool value = false;
  String title = "Not Available";
  Color color = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Switch(
          
            activeColor: mainColor,
            value: value,
            onChanged: (bool state) {
              setState(() {
                value = state;
                if (state) {
                  color = mainColor;
                  title = "Available";
                } else {
                  color = Colors.grey;
                  title = "Not Available";
                }
              });
            }),
        Text(
          title,
          style: TextStyle(color: color),
        )
      ],
    );
  }
}

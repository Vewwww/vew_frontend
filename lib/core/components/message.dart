import 'package:flutter/material.dart';
import 'package:vewww/core/style/app_colors.dart';

class Message extends StatelessWidget {
  bool isSent = true;
  String message;
  Color color = Colors.grey;
  Message({required this.isSent, required this.message, Key? key})
      : super(key: key) {
    if (!isSent)
      color = Colors.grey;
    else
      color = mainColor;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        (isSent)
            ? const Expanded(
                child: SizedBox(
                  width: 30,
                ),
              )
            : Container(),
        Flexible(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              color: color.withOpacity(0.08),
              border: Border.all(color: color),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            width: 200,
            child: Text(
              message,
              overflow: TextOverflow.fade,
              style: TextStyle(color: color),
            ),
          ),
        ),
        (!isSent)
            ? const Expanded(
                child: SizedBox(
                  width: 30,
                ),
              )
            : Container(),
      ],
    );
  }
}

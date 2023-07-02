import 'package:flutter/material.dart';
import 'package:vewww/core/style/app_colors.dart';
import '../style/app_Text_Style/app_text_style.dart';

class SidebarElement extends StatelessWidget {
  String? title;
  IconData? icon;
  Function? onpress;
  bool dot;
  SidebarElement(this.title, this.icon,
      {this.onpress, this.dot = false, super.key}) {
    onpress ??= () {};
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onpress!();
      },
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            title!,
            style: AppTextStyle.darkGreyStyle(size: 16),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.white.withOpacity(0),
            child: (dot)
                ? Stack(
                    children: [
                      Icon(
                        icon,
                        color: mainColor,
                      ),
                      Positioned(
                        right: 0,
                        top: 1,
                        child: CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.red.shade900,
                        ),
                      )
                    ],
                  )
                : Icon(
                    icon!,
                    color: mainColor,
                  ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/core/utils/navigation.dart';

import 'backward_arrow.dart';

class CustomAppBar extends StatelessWidget {
  Widget? title;
  Widget? leading;
  List<Widget>? actions;
  bool? haveBackArrow;
  bool? haveLogo;
  Color backgroundcolor;
  Color? iconColor;
  CustomAppBar(
      {this.title,
      this.leading,
      this.haveBackArrow,
      this.haveLogo,
      this.actions,
      this.backgroundcolor=const Color.fromARGB(98, 255, 255, 255),
      this.iconColor= const Color.fromRGBO(2, 113, 106, 1),
      Key? key})
      : super(key: key) {
    haveBackArrow ??= false;
    haveLogo ??= false;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:backgroundcolor,
      elevation: 0,
      centerTitle: true,
      title: (haveLogo!) ? Image.asset("assets/images/Logo(1).png") : title,
      leading: (haveBackArrow!)
          ? BackwardArrow(function: () {
              Navigator.pop(context);
            },
            )
          : leading,
      actions: actions,
    );
  }
}

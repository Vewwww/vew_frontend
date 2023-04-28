import 'package:flutter/material.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';

import '../core/components/chat_head_element.dart';
import '../core/components/custom_app_bar.dart';
import '../core/style/app_colors.dart';
import '../core/utils/navigation.dart';
import '../model/chat.dart';
import 'driver_home_screen.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          CustomAppBar(
            title: Text(
              "Chat",
              style: AppTextStyle.boldStyle(),
            ),
            leading: IconButton(
                onPressed: () {
                  NavigationUtils.navigateTo(
                      context: context, destinationScreen: DriverHomeScreen());
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: mainColor,
                )),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: chats.length,
                  itemBuilder: (context, index) =>
                      ChatHeadElement(chat: chats[index])))
        ],
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:vewww/bloc/chat_cubit/chat_cubit.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/core/utils/sp_helper/cache_helper.dart';
import 'package:vewww/model/chat.dart';

import '../../views/common/single_chat.dart';
import '../style/app_Text_Style/app_text_style.dart';
import '../utils/navigation.dart';

class ChatHeadElement extends StatelessWidget {
  Chat chat;
  ChatHeadElement({required this.chat, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white10, elevation: 0),
      onPressed: () {
        ChatCubit.get(context).setchat(chat);
        NavigationUtils.navigateTo(
            context: context, destinationScreen: SingleChat(chat: chat));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment:
              (SharedPreferencesHelper.getData(key: "vewRole") == "user")
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    chat.chatName!,
                    style: AppTextStyle.darkGreyStyle(size: 22),
                  ),
                  Text(
                    chat.messages![chat.messages!.length - 1].content!,
                    style: AppTextStyle.darkGreyStyle(size: 17),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    chat.messages![chat.messages!.length - 1].time!,
                    style: AppTextStyle.greyStyle(size: 12),
                  ),
                ],
              ),
            ),
            Container(
              width: 90,
              height: 90,
              margin: EdgeInsets.fromLTRB(20, 2, 10, 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: mainColor),
              child: const Icon(
                Icons.person_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

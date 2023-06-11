import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/chat_cubit/chat_cubit.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/model/chat.dart';
import 'package:vewww/views/common/chats_screen.dart';

import '../../core/components/custom_app_bar.dart';
import '../../core/components/message.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/utils/navigation.dart';

class SingleChat extends StatelessWidget {
  ChatModel chat;
  SingleChat({required this.chat, Key? key}) : super(key: key);
  final TextEditingController _message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ChatCubit chatCubit = ChatCubit.get(context);
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
                        context: context,
                        destinationScreen: const ChatsScreen());
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: mainColor,
                  )),
            ),
            BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: chat.messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (chat.messages[index].sender == "me") {
                        return Message(
                            isSent: true,
                            message: chat.messages[index].message);
                      } else {
                        return Message(
                            isSent: false,
                            message: chat.messages[index].message);
                      }
                    },
                  ),
                );
              },
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 3, 0, 10),
              child: Row(
                children: [
                  IconButton(
                      color: mainColor,
                      onPressed: () {
                        var index = chats.lastIndexOf(chat);
                        chatCubit.sendMessage(
                            MessageModel(
                                message: _message.text,
                                date: "now",
                                sender: "me"),
                            index);
                        _message.text = "";
                      },
                      icon: Icon(
                        Icons.send,
                        color: mainColor,
                      )),
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _message,
                      decoration: const InputDecoration(
                        hintTextDirection: TextDirection.rtl,
                        hintText: 'اكتب رسالتك...',
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                      ),
                      validator: (value) {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

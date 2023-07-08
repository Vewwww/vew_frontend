import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/chat_cubit/chat_cubit.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/core/utils/sp_helper/cache_helper.dart';
import 'package:vewww/model/chat.dart';
import 'package:vewww/views/common/chats_screen.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/components/message.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../core/utils/navigation.dart';

class SingleChat extends StatefulWidget {
  Chat chat;
  String? language; //ar = arabic , en= english
  SingleChat({required this.chat, this.language = "en", Key? key})
      : super(key: key);

  @override
  State<SingleChat> createState() => _SingleChatState();
}

class _SingleChatState extends State<SingleChat> {
  final TextEditingController _message = TextEditingController();
  @override
  void initState() {
    initSocket();
    super.initState();
  }
  IO.Socket? socket;

  initSocket() {
    socket = IO.io("https://vewwwapi.onrender.com/", <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    widget.language =
        (SharedPreferencesHelper.getData(key: "vewRole") == "user")
            ? "en"
            : "ar";
    socket!.connect();
    socket!.onConnect((_) {
      socket!.emit('join-room', {'room': widget.chat.room});
    });
    socket!.on("recieve-message", (data) {
      ChatCubit.get(context).reciveMessage(data, widget.chat);
    });
    socket!.onConnectError((err) => debugPrint(err));
    socket!.onError((err) => debugPrint(err));
  }

  @override
  Widget build(BuildContext context) {
    ChatCubit chatCubit = ChatCubit.get(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: Text(
                (widget.language == "en") ? "Chat" : "المحادثة",
                style: AppTextStyle.boldStyle(),
              ),
              leading: IconButton(
                  onPressed: () {
                    disconnect();
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
                    reverse: true,
                    itemCount: chatCubit.chat!.messages!.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (chatCubit
                              .chat!
                              .messages![
                                  chatCubit.chat!.messages!.length - 1 - index]
                              .sender ==
                          SharedPreferencesHelper.getData(key: "vewId")) {
                        return Message(
                            isSent: true,
                            message: chatCubit
                                .chat!
                                .messages![chatCubit.chat!.messages!.length -
                                    1 -
                                    index]
                                .content!);
                      } else {
                        return Message(
                            isSent: false,
                            message: chatCubit
                                .chat!
                                .messages![chatCubit.chat!.messages!.length -
                                    1 -
                                    index]
                                .content!);
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
                        socket!.emit("send-message", {
                          'room': widget.chat.room,
                          'chatId': widget.chat.sId,
                          'sender':
                              SharedPreferencesHelper.getData(key: "vewId"),
                          'content': _message.text,
                        });
                        _message.text = '';
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
                      decoration: InputDecoration(
                        hintTextDirection: (widget.language == "ar")
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        hintText: (widget.language == "ar")
                            ? 'اكتب رسالتك...'
                            : ' write your message...',
                        isDense: true,
                        contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                      ),
                      validator: (value) {},
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void disconnect() {
    socket!.disconnect();
    socket!.dispose();
  }

  @override
  void dispose() {
    socket!.disconnect();
    socket!.dispose();
    super.dispose();
  }
}

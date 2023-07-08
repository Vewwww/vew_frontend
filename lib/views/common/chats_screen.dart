import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/core/components/empty_requests.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/core/utils/sp_helper/cache_helper.dart';
import 'package:vewww/views/mechanic/mechanic_home_screen.dart';
import 'package:vewww/views/winch/winch_home_page.dart';
import '../../bloc/chat_cubit/chat_cubit.dart';
import '../../core/components/chat_head_element.dart';
import '../../core/components/custom_app_bar.dart';
import '../../core/style/app_colors.dart';
import '../../core/utils/navigation.dart';
import '../driver/driver_home_screen.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  void initState() {
    super.initState();
    var chatCubit = context.read<ChatCubit>();
    String role = SharedPreferencesHelper.getData(key: "vewRole");
    if (role == "winch") {
      chatCubit.getWinchChats();
    } else if (role == "user") {
      chatCubit.getDriverChats();
    } else if (role == "mechanic") {
      chatCubit.getMechanicChats();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment:
            (SharedPreferencesHelper.getData(key: "vewRole") == "user")
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
        children: [
          CustomAppBar(
            title: Text(
              (SharedPreferencesHelper.getData(key: "vewRole") == "user")
                  ? "Chat"
                  : "المحادثات",
              style: AppTextStyle.boldStyle(),
            ),
            leading: IconButton(
                onPressed: () {
                  String role = SharedPreferencesHelper.getData(key: "vewRole");
                  NavigationUtils.navigateTo(
                      context: context,
                      destinationScreen: (role == "user")
                          ? const DriverHomeScreen()
                          : (role == "winch")
                              ? WinchHomePage()
                              : MechanicHomeScreen());
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: mainColor,
                )),
          ),
          BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              if (state is GettingChatsSuccessState) {
                if (state.chats.isNotEmpty) {
                  return Expanded(
                      child: ListView.builder(
                          itemCount: state.chats.length,
                          itemBuilder: (context, index) {
                            return ChatHeadElement(chat: state.chats[index]);
                          }));
                } else {
                  return SizedBox(
                    height: 400,
                    child: EmptyRequests(
                      text: "No chats",
                    ),
                  );
                }
              } else {
                return Center(
                    child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 3),
                    const CircularProgressIndicator(),
                  ],
                ));
              }
            },
          )
        ],
      )),
    );
  }
}

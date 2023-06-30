import 'package:flutter/material.dart';
import 'package:vewww/bloc/auth_cubit/auth_cubit.dart';
import 'package:vewww/bloc/chat_cubit/chat_cubit.dart';
import 'package:vewww/core/components/sidebar_element.dart';
import '../../views/common/chats_screen.dart';
import '../../views/driver/sign_in_screen.dart';
import 'logo.dart';

class Sidebar extends StatelessWidget {
  Function function;
  Sidebar({super.key, required this.function});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 3 / 5,
      child: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          Logo(
            size: 150,
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            height: 1.5,
            color: Colors.grey,
          ),
          SidebarElement(
            "الملف الشخصى",
            Icons.person_outline,
            onpress: function,
          ),
          SidebarElement(
            "المحادثات",
            Icons.chat_rounded,
            dot: (ChatCubit.get(context).chatResponse != null)
                ? ChatCubit.get(context).chatResponse!.newChats!
                : false,
            onpress: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatsScreen()),
                  (route) => true);
            },
          ),
          SidebarElement(
            "تسجيل الخروج",
            Icons.logout_rounded,
            onpress: () async {
              await AuthCubit.get(context).logout();
              if (AuthCubit.get(context).state is LogoutSuccessState) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                    (route) => true);
              } else {
                var snackBar =
                    SnackBar(content: Text("Something went wrong , try again"));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
          ),
        ],
      ),
    );
  }
}

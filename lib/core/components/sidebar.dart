import 'package:flutter/material.dart';
import 'package:vewww/core/components/sidebar_element.dart';

import '../../views/common/chats_screen.dart';
import '../../views/common/sign_in_screen.dart';
import '../../views/winch/winch_profile.dart';
import 'logo.dart';


class Sidebar extends StatelessWidget {
  const Sidebar({super.key});
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
            onpress: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const WinchProfile()),
                  (route) => true);
            },
          ),
          
          SidebarElement(
            "المحادثات",
            Icons.chat_rounded,
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
            onpress: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                  (route) => true);
            },
          ),
        ],
      ),
    );
  }
}

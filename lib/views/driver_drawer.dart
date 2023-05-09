import 'package:flutter/material.dart';
import 'package:vewww/core/components/circular_icon.dart';
import 'package:vewww/core/components/horizontal_line.dart';
import 'package:vewww/core/utils/navigation.dart';
import 'package:vewww/views/change_password_screen.dart';
import 'package:vewww/views/chats_screen.dart';
import 'package:vewww/views/notifications_screen.dart';

import '../core/components/logo.dart';
import 'sign_in_screen.dart';

class DriverDrawer extends StatelessWidget {
  const DriverDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(10.0),

        child: Column(children: [
          //logo first
          SizedBox(height: 30),
          Logo(
            size: 180,
          ),
          SizedBox(height: 30),
          HorizontalLine(),
          SizedBox(height: 10),
          Row(
            children: [
              circularIcon(
                  child: const Icon(
                Icons.person,
                size: 30,
              )),
              const SizedBox(
                width: 15,
              ),
              const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 20,
                ),
              )
            ],
          ),

          // Row(
          //   children: [
          //     circularIcon(child: Switch(value: value, onChanged: onChanged))
          //   ],
          // ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: (){
              NavigationUtils.navigateAndClearStack(
                  context: context,
                  destinationScreen: ChangePasswordScreen());
            },
            child: Row(
              children: [
                circularIcon(child: const Icon(Icons.lock)),
                const SizedBox(
                  width: 15,
                ),
                const Text(
                  'Change Password',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              NavigationUtils.navigateAndClearStack(
                  context: context,
                  destinationScreen: const NotificationsScreen());
            },
            child: Row(
              children: [
                circularIcon(child: const Icon(Icons.notifications)),
                const SizedBox(
                  width: 15,
                ),
                const Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              NavigationUtils.navigateAndClearStack(
                  context: context, destinationScreen: ChatsScreen());
            },
            child: Row(
              children: [
                circularIcon(child: const Icon(Icons.chat)),
                const SizedBox(
                  width: 15,
                ),
                const Text(
                  'Chat',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              NavigationUtils.navigateAndClearStack(
                  context: context, destinationScreen: SignInScreen());
            },
            child: Row(
              children: [
                circularIcon(child: const Icon(Icons.logout)),
                const SizedBox(
                  width: 15,
                ),
                const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:vewww/bloc/auth_cubit/auth_cubit.dart';
import 'package:vewww/core/components/circular_icon.dart';
import 'package:vewww/core/components/horizontal_line.dart';
import 'package:vewww/core/utils/navigation.dart';
//import 'package:vewww/views/change_password_screen.dart';
import 'package:vewww/views/common/chats_screen.dart';
import 'package:vewww/views/driver/notifications_screen.dart';

import '../../core/components/logo.dart';
import '../../model/driver.dart';
import '../common/change_password_screen.dart';
import 'driver_profile.dart';
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
          GestureDetector(
            onTap: () {
              NavigationUtils.navigateAndClearStack(
                  context: context,
                  destinationScreen: DriverProfile(
                    driver: driver,
                  ));
            },
            child: CircularIcon(
                title: 'Profile',
                child: const Icon(
                  Icons.person,
                  size: 30,
                )),
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
            onTap: () {
              //TODO::change password screen
              NavigationUtils.navigateAndClearStack(
                  context: context, destinationScreen: ChangePasswordScreen());
            },
            child: CircularIcon(
                child: const Icon(Icons.lock), title: 'Change Password'),
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
            child: CircularIcon(
                title: 'Notifications', child: const Icon(Icons.notifications)),
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              NavigationUtils.navigateAndClearStack(
                  context: context, destinationScreen: ChatsScreen());
            },
            child: CircularIcon(title: 'Chat', child: const Icon(Icons.chat)),
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () async {
              await AuthCubit.get(context).logout();
              if (AuthCubit.get(context).state is LogoutSuccessState)
                NavigationUtils.navigateAndClearStack(
                    context: context, destinationScreen: SignInScreen());
              else {
                const snackBar =
                    SnackBar(content: Text("Something went wrong try again !"));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child:
                CircularIcon(title: 'Logout', child: const Icon(Icons.logout)),
          ),
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/auth_cubit/auth_cubit.dart';
import 'package:vewww/core/components/circular_icon.dart';
import 'package:vewww/core/components/horizontal_line.dart';
import 'package:vewww/core/utils/navigation.dart';
//import 'package:vewww/views/change_password_screen.dart';
import 'package:vewww/views/common/chats_screen.dart';
import 'package:vewww/views/driver/notifications_screen.dart';
import 'package:vewww/views/driver/prev_req_screen.dart';
import 'package:vewww/views/driver/current_requests_screen.dart';

import '../../bloc/notification_cubit/notification_cubit.dart';
import '../../core/components/logo.dart';
import '../../model/driver.dart';
import '../common/change_password_screen.dart';
import 'driver_profile.dart';
import 'pendding_requests_screen.dart';
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
          horizontalLine(),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              NavigationUtils.navigateAndClearStack(
                  context: context, destinationScreen: DriverProfile());
            },
            child: circularIcon(
                title: 'Profile',
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
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
            child: circularIcon(
                child: const Icon(Icons.lock, color: Colors.white),
                title: 'Change Password'),
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
            child: circularIcon(
                title: 'Notifications',
                child: BlocBuilder<NotificationCubit, NotificationState>(
                  builder: (context, state) {
                    if (state is GettingNotificationSuccessState &&
                        NotificationCubit.get(context).haveNew)
                      return Stack(
                        children: [
                          const Icon(Icons.notifications, color: Colors.white),
                          Positioned(
                            right: 0,
                            top: 1,
                            child: CircleAvatar(
                              radius: 5,
                              backgroundColor: Colors.red.shade900,
                            ),
                          )
                        ],
                      );
                    else
                      return Icon(
                        Icons.notifications,
                        color: Colors.white,
                      );
                  },
                )),
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              NavigationUtils.navigateAndClearStack(
                  context: context, destinationScreen: ChatsScreen());
            },
            child: circularIcon(
                title: 'Chat',
                child: const Icon(Icons.chat, color: Colors.white)),
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              NavigationUtils.navigateAndClearStack(
                  context: context, destinationScreen: PreviousReqScreen());
            },
            child: circularIcon(
                title: 'Previous Requests',
                child: const Icon(Icons.skip_previous, color: Colors.white)),
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              NavigationUtils.navigateAndClearStack(
                  context: context, destinationScreen: CurrentRequestsScreen());
            },
            child: circularIcon(
                title: 'Current Requests',
                child: const Icon(Icons.event_available_outlined,
                    color: Colors.white)),
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              NavigationUtils.navigateAndClearStack(
                  context: context,
                  destinationScreen: PenddingRequestsScreen());
            },
            child: circularIcon(
                title: 'Pendding Requests',
                child: const Icon(Icons.timer, color: Colors.white)),
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
            child: circularIcon(
                title: 'Logout',
                child: const Icon(Icons.logout, color: Colors.white)),
          ),
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/components/notification_card.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/core/utils/navigation.dart';
import 'package:vewww/model/notification.dart';
import 'package:vewww/views/driver/driver_home_screen.dart';

import '../../bloc/notification_cubit/notification_cubit.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    var notificationCubit = context.read<NotificationCubit>();
    notificationCubit.getNotificatin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SafeArea(
            child: Column(
          children: [
            CustomAppBar(
              title: Text("Notifications", style: AppTextStyle.boldStyle()),
              leading: IconButton(
                  onPressed: () {
                    NavigationUtils.navigateTo(
                        context: context,
                        destinationScreen: DriverHomeScreen());
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: mainColor,
                  )),
            ),
            BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
                if (state is GettingNotificationSuccessState) {
                  if (NotificationCubit.get(context)
                          .notifivatoinResponse!
                          .notifications!
                          .length >
                      0)
                    return Expanded(
                        child: ListView.builder(
                            itemCount: NotificationCubit.get(context)
                                .notifivatoinResponse!
                                .notifications!
                                .length,
                            itemBuilder: (context, index) => NotificationCard(
                                notification: NotificationCubit.get(context)
                                    .notifivatoinResponse!
                                    .notifications![index])));
                  else
                    return Center(
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 200,
                            ),
                            Image.asset(
                              "assets/images/Empty.png",
                              width: 200,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "You Don't have Notification",
                              textDirection: TextDirection.rtl,
                              style: AppTextStyle.lightGrayTextStyle(25),
                            ),
                          ],
                        ),
                      ),
                    );
                } else {
                  return Center(
                      child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 3),
                      CircularProgressIndicator(),
                    ],
                  ));
                }
              },
            )
          ],
        )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/components/notification_card.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/core/utils/navigation.dart';
import 'package:vewww/model/notification.dart';
import 'package:vewww/views/driver/driver_home_screen.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

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
            Expanded(
                child: ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) =>
                        NotificationCard(notification: notifications[index])))
          ],
        )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';

import '../../model/notification.dart';

class NotificationCard extends StatelessWidget {
  AppNotification notification;
  NotificationCard({required this.notification, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(thickness: 0.8),
          Text(notification.message),
          Text(
            notification.date,
            style: AppTextStyle.greyStyle(size: 12),
          ),
          const Divider(thickness: 0.8),
        ],
      ),
    );
  }
}

part of 'notification_cubit.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}
class GettingNotificationLoadingState extends NotificationState {}
class GettingNotificationSuccessState extends NotificationState {
  final List<AppNotification> notifications;
  GettingNotificationSuccessState(this.notifications);
}
class GettingNotificationErrorState extends NotificationState {}

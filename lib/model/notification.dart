class AppNotification {
  String message;
  String date;

  AppNotification({required this.message, required this.date});
}

List<AppNotification> notifications = [
  AppNotification(
      message:
          "Your Request has been accepted from  winch owner Ahmed Allam. You can chat with him and contact each other.",
      date: "12:01 12 Mar"),
  AppNotification(
      message:
          "It’s time to renew you your car license. Current license ends at 25-3-2032.",
      date: "02:12 Today"),
];

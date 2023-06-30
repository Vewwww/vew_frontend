class NotifivatoinResponse {
  bool? newNotifications;
  List<AppNotification>? notifications;

  NotifivatoinResponse({this.newNotifications, this.notifications});

  NotifivatoinResponse.fromJson(Map<String, dynamic> json) {
    newNotifications = json['newNotifications'];
    if (json['data'] != null) {
      notifications = <AppNotification>[];
      json['data'].forEach((v) {
        notifications!.add(AppNotification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['newNotifications'] = newNotifications;
    if (notifications != null) {
      data['data'] = notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppNotification {
  String? sId;
  String? message;
  String? date;
  String? to;
  bool? seen;
  int? iV;

  AppNotification({this.sId, this.message, this.date, this.to, this.seen, this.iV});

  AppNotification.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    message = json['message'];
    date = json['date'];
    to = json['to'];
    seen = json['seen'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['message'] = message;
    data['date'] = date;
    data['to'] = to;
    data['seen'] = seen;
    data['__v'] = iV;
    return data;
  }
}

class AdminResponse {
  List<Admin>? admins;

  AdminResponse({this.admins});

  AdminResponse.fromJson(Map<String, dynamic> json) {
    if (json['admins'] != null) {
      admins = <Admin>[];
      json['admins'].forEach((v) {
        admins!.add(Admin.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (admins != null) {
      data['admins'] = admins!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class AdminProfileResponse {
  Admin? admin;

  AdminProfileResponse({this.admin});

  AdminProfileResponse.fromJson(Map<String, dynamic> json) {
    admin = json['data'] != null ? Admin.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (admin != null) {
      data['data'] = admin!.toJson();
    }
    return data;
  }
}

class Admin {
  Report? report;
  String? sId;
  String? name;
  String? email;
  String? password;
  String? phoneNumber;
  String? gender;
  String? role;
  String? driverLisenceRenewalDate;
  bool? isSuspended;
  bool? emailConfirm;
  bool? logedIn;
  bool? passwordReset;
  int? iV;
  String? driverLisenceRenewalNotification;

  Admin(
      {this.report,
      this.sId,
      this.name,
      this.email,
      this.password,
      this.phoneNumber,
      this.gender,
      this.role,
      this.driverLisenceRenewalDate,
      this.isSuspended,
      this.emailConfirm,
      this.logedIn,
      this.passwordReset,
      this.iV,
      this.driverLisenceRenewalNotification});

  Admin.fromJson(Map<String, dynamic> json) {
    report =
        json['report'] != null ? Report.fromJson(json['report']) : null;
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    role = json['role'];
    driverLisenceRenewalDate = json['driverLisenceRenewalDate'];
    isSuspended = json['isSuspended'];
    emailConfirm = json['emailConfirm'];
    logedIn = json['logedIn'];
    passwordReset = json['passwordReset'];
    iV = json['__v'];
    driverLisenceRenewalNotification = json['driverLisenceRenewalNotification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (report != null) {
      data['report'] = report!.toJson();
    }
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['phoneNumber'] = phoneNumber;
    data['gender'] = gender;
    data['role'] = role;
    data['driverLisenceRenewalDate'] = driverLisenceRenewalDate;
    data['isSuspended'] = isSuspended;
    data['emailConfirm'] = emailConfirm;
    data['logedIn'] = logedIn;
    data['passwordReset'] = passwordReset;
    data['__v'] = iV;
    data['driverLisenceRenewalNotification'] =
        driverLisenceRenewalNotification;
    return data;
  }
}

class Report {
  int? reportsNumber;
  String? dateReport;

  Report({this.reportsNumber, this.dateReport});

  Report.fromJson(Map<String, dynamic> json) {
    reportsNumber = json['reportsNumber'];
    dateReport = json['dateReport'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reportsNumber'] = reportsNumber;
    data['dateReport'] = dateReport;
    return data;
  }
}
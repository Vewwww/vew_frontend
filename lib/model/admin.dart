import 'package:vewww/model/person.dart';

class AdminResponse {
  List<Admin>? admins;

  AdminResponse({this.admins});

  AdminResponse.fromJson(Map<String, dynamic> json) {
    if (json['admins'] != null) {
      admins = <Admin>[];
      json['admins'].forEach((v) {
        admins!.add(new Admin.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.admins != null) {
      data['admins'] = this.admins!.map((v) => v.toJson()).toList();
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
        json['report'] != null ? new Report.fromJson(json['report']) : null;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.report != null) {
      data['report'] = this.report!.toJson();
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phoneNumber'] = this.phoneNumber;
    data['gender'] = this.gender;
    data['role'] = this.role;
    data['driverLisenceRenewalDate'] = this.driverLisenceRenewalDate;
    data['isSuspended'] = this.isSuspended;
    data['emailConfirm'] = this.emailConfirm;
    data['logedIn'] = this.logedIn;
    data['passwordReset'] = this.passwordReset;
    data['__v'] = this.iV;
    data['driverLisenceRenewalNotification'] =
        this.driverLisenceRenewalNotification;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reportsNumber'] = this.reportsNumber;
    data['dateReport'] = this.dateReport;
    return data;
  }
}
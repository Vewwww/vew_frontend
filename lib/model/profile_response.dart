import 'car.dart';

class ProfileResponse {
  ProfileData? data;

  ProfileResponse({this.data});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ProfileData {
  User? user;
  List<Car>? cars;

  ProfileData({this.user, this.cars});

  ProfileData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['cars'] != null) {
      cars = <Car>[];
      json['cars'].forEach((v) {
        cars!.add(new Car.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.cars != null) {
      data['cars'] = this.cars!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  Report? report;
  String? sId;
  String? name;
  String? email;
  String? password;
  String? phoneNumber;
  String? gender;
  String? role;
  String? lisenceRenewalDate;
  bool? isSuspended;
  bool? emailConfirm;
  bool? logedIn;
  int? iV;
  bool? passwordReset;

  User(
      {this.report,
      this.sId,
      this.name,
      this.email,
      this.password,
      this.phoneNumber,
      this.gender,
      this.role,
      this.lisenceRenewalDate,
      this.isSuspended,
      this.emailConfirm,
      this.logedIn,
      this.iV,
      this.passwordReset});

  User.fromJson(Map<String, dynamic> json) {
    report =
        json['report'] != null ? new Report.fromJson(json['report']) : null;
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    role = json['role'];
    lisenceRenewalDate = json['lisenceRenewalDate'];
    isSuspended = json['isSuspended'];
    emailConfirm = json['emailConfirm'];
    logedIn = json['logedIn'];
    iV = json['__v'];
    passwordReset = json['passwordReset'];
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
    data['lisenceRenewalDate'] = this.lisenceRenewalDate;
    data['isSuspended'] = this.isSuspended;
    data['emailConfirm'] = this.emailConfirm;
    data['logedIn'] = this.logedIn;
    data['__v'] = this.iV;
    data['passwordReset'] = this.passwordReset;
    return data;
  }
}

class Report {
  String? dateReport;
  int? reportsNumber;

  Report({this.dateReport, this.reportsNumber});

  Report.fromJson(Map<String, dynamic> json) {
    dateReport = json['dateReport'];
    reportsNumber = json['reportsNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateReport'] = this.dateReport;
    data['reportsNumber'] = this.reportsNumber;
    return data;
  }
}

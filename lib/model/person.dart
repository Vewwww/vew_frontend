import 'report.dart';

class SignInResponse {
  Person? person;

  SignInResponse({this.person});

  SignInResponse.fromJson(Map<String, dynamic> json) {
    var token = json['token'];
    person = json['user'] != null ? Person.fromJson(json['user']) : null;
    person!.token = token;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = person!.token;
    if (person != null) {
      data['user'] = person!.toJson();
    }
    return data;
  }
}

class Person {
  Report? report;
  String? sId;
  String? name;
  String? token;
  String? email;
  bool? available;
  String? password;
  String? phoneNumber;
  String? gender;
  String? role;
  String? lisenceRenewalDate;
  bool? isSuspended;
  bool? emailConfirm;
  bool? logedIn;
  int? iV;

  Person(
      {this.report,
      this.sId,
      this.name,
      this.email,
      this.password,
      this.phoneNumber,
      this.gender,
      this.available,
      this.role,
      this.token,
      this.lisenceRenewalDate,
      this.isSuspended,
      this.emailConfirm,
      this.logedIn,
      this.iV});

  Person.fromJson(Map<String, dynamic> json) {
    report = json['report'] != null ? Report.fromJson(json['report']) : null;
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    role = json['role'];
    available = json['available'];
    lisenceRenewalDate = json['lisenceRenewalDate'];
    isSuspended = json['isSuspended'];
    emailConfirm = json['emailConfirm'];
    logedIn = json['logedIn'];
    iV = json['__v'];
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
    data['lisenceRenewalDate'] = lisenceRenewalDate;
    data['isSuspended'] = isSuspended;
    data['emailConfirm'] = emailConfirm;
    data['logedIn'] = logedIn;
    data['__v'] = iV;
    return data;
  }
}

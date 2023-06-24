class SignInResponse {
  Person? person;

  SignInResponse({this.person});

  SignInResponse.fromJson(Map<String, dynamic> json) {
    print("data from signresponse from json = $json");
    var token = json['token'];
    person = json['user'] != null ? new Person.fromJson(json['user']) : null;
    person!.token = token;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.person!.token;
    if (this.person != null) {
      data['user'] = this.person!.toJson();
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
      this.role,
      this.token,
      this.lisenceRenewalDate,
      this.isSuspended,
      this.emailConfirm,
      this.logedIn,
      this.iV});

  Person.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.report != null) {
      data['report'] = this.report!.toJson();
    }
    // data['token'] = this.token;
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

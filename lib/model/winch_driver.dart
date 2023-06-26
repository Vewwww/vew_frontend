import 'package:vewww/model/person.dart';

class WinchDriverResponse {
  int? results;
  List<WinchDriver>? winchDriver;

  WinchDriverResponse({this.results, this.winchDriver});

  WinchDriverResponse.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    if (json['data'] != null) {
      winchDriver = <WinchDriver>[];
      json['data'].forEach((v) {
        winchDriver!.add(new WinchDriver.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results'] = this.results;
    if (this.winchDriver != null) {
      data['data'] = this.winchDriver!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WinchDriver {
  Location? location;
  bool? available;
  Person? person;
  Report? report;
  String? sId;
  String? name;
  String? email;
  String? password;
  String? phoneNumber;
  double? rate;
  int? numOfRates;
  bool? isSuspended;
  bool? emailConfirm;
  bool? logedIn;
  String? role;
  int? iV;

  WinchDriver(
      {this.report,
      this.location,
      this.available,
      this.sId,
      this.name,
      this.email,
      this.password,
      this.phoneNumber,
      this.rate,
      this.numOfRates,
      this.isSuspended,
      this.emailConfirm,
      this.logedIn,
      this.role,
      this.iV});

  WinchDriver.fromJson(Map<String, dynamic> json) {
    report =
        json['report'] != null ? new Report.fromJson(json['report']) : null;
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    available = json['available'];
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    rate = json['rate'];
    numOfRates = json['numOfRates'];
    isSuspended = json['isSuspended'];
    emailConfirm = json['emailConfirm'];
    logedIn = json['logedIn'];
    role = json['role'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.report != null) {
      data['report'] = this.report!.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['available'] = this.available;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phoneNumber'] = this.phoneNumber;
    data['rate'] = this.rate;
    data['numOfRates'] = this.numOfRates;
    data['isSuspended'] = this.isSuspended;
    data['emailConfirm'] = this.emailConfirm;
    data['logedIn'] = this.logedIn;
    data['role'] = this.role;
    data['__v'] = this.iV;
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

class Location {
  double? latitude;
  double? longitude;

  Location({this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
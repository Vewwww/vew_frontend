import 'location.dart';
import 'report.dart';

class WinchDriverResponse {
  int? results;
  List<WinchDriver>? winchDriver;

  WinchDriverResponse({this.results, this.winchDriver});

  WinchDriverResponse.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    if (json['data'] != null) {
      winchDriver = <WinchDriver>[];
      json['data'].forEach((v) {
        winchDriver!.add(WinchDriver.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results;
    if (winchDriver != null) {
      data['data'] = winchDriver!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class WinchProfileResponse {
  String? status;
  WinchDriver? winch;

  WinchProfileResponse({this.status, this.winch});

  WinchProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    winch = json['data'] != null ? WinchDriver.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (winch != null) {
      data['data'] = winch!.toJson();
    }
    return data;
  }
}

class WinchDriver {
  Location? location;
  bool? available;
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
  String? plateNumber;
  int? iV;

  WinchDriver(
      {this.report,
      this.location,
      this.available,
      this.sId,
      this.name,
      this.email,
      this.plateNumber,
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
    report = json['report'] != null ? Report.fromJson(json['report']) : null;
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    available = json['available'];
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    rate = json['rate'] *1.0 ;
    numOfRates = json['numOfRates'];
    isSuspended = json['isSuspended'];
    emailConfirm = json['emailConfirm'];
    plateNumber = json['plateNumber'];
    logedIn = json['logedIn'];
    role = json['role'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (report != null) {
      data['report'] = report!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (available != null) data['available'] = available;
    if (sId != null) data['_id'] = sId;
    if (name != null) data['name'] = name;
    if (email != null) data['email'] = email;
    if (password != null) data['password'] = password;
    if (phoneNumber != null) data['phoneNumber'] = phoneNumber;
    if (rate != null) data['rate'] = rate;
    if (numOfRates != null) data['numOfRates'] = numOfRates;
    if (isSuspended != null) data['isSuspended'] = isSuspended;
    if (plateNumber != null) data['plateNumber'] = plateNumber;
    if (emailConfirm != null) data['emailConfirm'] = emailConfirm;
    if (logedIn != null) data['logedIn'] = logedIn;
    if (role != null) data['role'] = role;
    if (iV != null) data['__v'] = iV;
    return data;
  }
}

import 'car.dart';
import 'report.dart';

class ProfileResponse {
  ProfileData? data;

  ProfileResponse({this.data});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['cars'] != null) {
      cars = <Car>[];
      json['cars'].forEach((v) {
        cars!.add(Car.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (cars != null) {
      data['cars'] = cars!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  Report? report;
  String? sId;
  String? name;
  String? email;
  String? phoneNumber;
  String? gender;
  String? role;
  int? iV;
  String? driverLisenceRenewalNotification;

  User(
      {this.report,
      this.sId,
      this.name,
      this.email,
      this.phoneNumber,
      this.gender,
      this.role,
      this.iV,
      this.driverLisenceRenewalNotification});

  User.fromJson(Map<String, dynamic> json) {
    report =
        json['report'] != null ? Report.fromJson(json['report']) : null;
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    role = json['role'];
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
    data['phoneNumber'] = phoneNumber;
    data['gender'] = gender;
    data['role'] = role;
    data['__v'] = iV;
    data['driverLisenceRenewalNotification'] =
        driverLisenceRenewalNotification;
    return data;
  }
}

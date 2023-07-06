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
    print("user to json done");
    if (json['cars'] != null) {
      cars = <Car>[];
      json['cars'].forEach((v) {
        cars!.add(Car.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    if (this.report != null) {
      data['report'] = this.report!.toJson();
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['gender'] = this.gender;
    data['role'] = this.role;
    data['__v'] = this.iV;
    data['driverLisenceRenewalNotification'] =
        this.driverLisenceRenewalNotification;
    return data;
  }
}

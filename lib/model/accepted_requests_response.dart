import 'package:vewww/model/car.dart';
import 'package:vewww/model/location.dart';
import 'package:vewww/model/repairer.dart';
import 'package:vewww/model/services.dart';

import 'driver.dart';

class AcceptedRequestsResponse {
  List<MechanicRequestsData>? data;

  AcceptedRequestsResponse({this.data});

  AcceptedRequestsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MechanicRequestsData>[];
      json['data'].forEach((v) {
        data!.add(new MechanicRequestsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MechanicRequestsData {
  Location? location;
  String? sId;
  Service? service;
  Driver? driver;
  Car? car;
  Mechanic? mechanic;
  String? createdAt;

  MechanicRequestsData(
      {this.location,
      this.sId,
      this.service,
      this.driver,
      this.car,
      this.mechanic,
      this.createdAt});

  MechanicRequestsData.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
    driver =
        json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
    car = json['car'] != null ? new Car.fromJson(json['car']) : null;
    mechanic = json['mechanic'] != null
        ? new Mechanic.fromJson(json['mechanic'])
        : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['_id'] = this.sId;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    if (this.car != null) {
      data['car'] = this.car!.toJson();
    }
    if (this.mechanic != null) {
      data['mechanic'] = this.mechanic!.toJson();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

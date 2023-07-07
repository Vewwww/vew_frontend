import 'package:vewww/model/car.dart';
import 'package:vewww/model/location.dart';
import 'package:vewww/model/repairer.dart';
import 'package:vewww/model/services.dart';
import 'driver.dart';

class MechanicAcceptedRequestsResponse {
  List<MechanicRequestsData>? data;

  MechanicAcceptedRequestsResponse({this.data});

  MechanicAcceptedRequestsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MechanicRequestsData>[];
      json['data'].forEach((v) {
        data!.add(MechanicRequestsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
        ? Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    service =
        json['service'] != null ? Service.fromJson(json['service']) : null;
    driver =
        json['driver'] != null ? Driver.fromJson(json['driver']) : null;
    car = json['car'] != null ? Car.fromJson(json['car']) : null;
    mechanic = json['mechanic'] != null
        ? Mechanic.fromJson(json['mechanic'])
        : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['_id'] = sId;
    if (service != null) {
      data['service'] = service!.toJson();
    }
    if (driver != null) {
      data['driver'] = driver!.toJson();
    }
    if (car != null) {
      data['car'] = car!.toJson();
    }
    if (mechanic != null) {
      data['mechanic'] = mechanic!.toJson();
    }
    data['created_at'] = createdAt;
    return data;
  }
}

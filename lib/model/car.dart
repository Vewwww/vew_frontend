import 'package:flutter/material.dart';
//TODO::confirm scheme with back team
// class Car {
//   String? carType;
//   String? carModel;
//   Color? color;
//   String? lastPeriodicMaintenanceDate;
//   String? licenseRenewalDate;
//   String? currentMiles;
//   String? averageMileperWeek;
//   String? remindYouBefore;
//   Car(
//       {this.averageMileperWeek,
//       this.carModel,
//       this.carType,
//       this.color,
//       this.currentMiles,
//       this.lastPeriodicMaintenanceDate,
//       this.licenseRenewalDate,
//       this.remindYouBefore});
// }

class Car {
  String? carType;
  String? color;
  String? plateNumber;

  Car({this.carType, this.color, this.plateNumber});

  Car.fromJson(Map<String, dynamic> json) {
    carType = json['carType'];
    color = json['color'];
    plateNumber = json['plateNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carType'] = this.carType;
    data['color'] = this.color;
    data['plateNumber'] = this.plateNumber;
    return data;
  }
}
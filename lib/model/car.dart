import 'package:flutter/material.dart';

class Car {
  String? carType;
  String? carModel;
  Color? color;
  String? lastPeriodicMaintenanceDate;
  String? licenseRenewalDate;
  String? currentMiles;
  String? averageMileperWeek;
  String? remindYouBefore;
  Car(
      {this.averageMileperWeek,
      this.carModel,
      this.carType,
      this.color,
      this.currentMiles,
      this.lastPeriodicMaintenanceDate,
      this.licenseRenewalDate,
      this.remindYouBefore});
}

import 'car_color.dart';
import 'car_model.dart';
import 'car_type.dart';

class CarResponse {
  int? results;
  List<Car>? car;

  CarResponse({this.results, this.car});

  CarResponse.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    if (json['data'] != null) {
      car = <Car>[];
      json['data'].forEach((v) {
        car!.add(Car.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results;
    if (car != null) {
      data['data'] = car!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

String? periodicMaintenanceNotification;

class Car {
  String? sId;
  CarType? carType;
  String? plateNumber;
  CarColor? color;
  String? owner;
  int? iV;
  CarModel? carModel;
  String? year;
  String? carLicenseRenewalDate;
  double? miles;
  double? averageMilesPerMonth;
  String? lastPeriodicMaintenanceDate;

  Car(
      {this.sId,
      this.carType,
      this.plateNumber,
      this.color,
      this.owner,
      this.iV,
      this.carModel,
      this.year,
      this.carLicenseRenewalDate,
      this.miles,
      this.averageMilesPerMonth,
      this.lastPeriodicMaintenanceDate});

  Car.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['carType'] is String) {
      carType = CarType(sId: json['carType']);
    } else {
      carType = CarType.fromJson(json['carType']);
    }

    plateNumber = json['plateNumber'];
    if (json['color'] != null) {
      if (json['color'] is String) {
        color = CarColor(sId: json['color']);
      } else {
        color = CarColor.fromJson(json['color']);
      }
    }
    owner = json['owner'] ?? "";
    iV = json['__v'];
    if (json['carModel'] != null) {
      if (json['carModel'] is String) {
        carModel = CarModel(sId: json['carModel']);
      } else {
        carModel = CarModel.fromJson(json['carModel']);
      }
    }
    year = json['year'];
    carLicenseRenewalDate =
        json['CarLicenseRenewalDate'] ?? json['carLicenseRenewalNotifition'];
    if (json['miles'] != null) miles = json['miles'] * 1.0;
    if (json['averageMilesPerMonth'] != null) {
      averageMilesPerMonth = json['averageMilesPerMonth'] * 1.0;
    }
    lastPeriodicMaintenanceDate = json['lastPeriodicMaintenanceDate'] ??
        json['periodicMaintenanceNotification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (carType != null) data['carType'] = carType!.toJson();
    data['plateNumber'] = plateNumber;
    if (color != null) data['color'] = color!.toJson();
    data['owner'] = owner;
    data['__v'] = iV;
    if (carModel != null) data['carModel'] = carModel!.toJson();
    data['year'] = year;
    data['carLicenseRenewalDate'] = carLicenseRenewalDate;
    data['carLicenseRenewalNotifition'] = carLicenseRenewalDate;
    data['miles'] = miles;
    data['averageMilesPerMonth'] = averageMilesPerMonth;
    data['lastPeriodicMaintenanceDate'] = lastPeriodicMaintenanceDate;
    return data;
  }

  Map<String, dynamic> upadateToJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sId != null) data['_id'] = sId;
    if (carType != null) data['carType'] = carType!.sId;
    data['plateNumber'] = plateNumber;
    data['year'] = year;
    if (carModel != null) data['carModel'] = carModel!.sId;
    if (color != null) data['color'] = color!.sId;
    data['owner'] = owner;
    if (iV != null) data['__v'] = iV;
    if (carLicenseRenewalDate != null) {
      data['carLicenseRenewalDate'] = carLicenseRenewalDate.toString();
    }
    if (lastPeriodicMaintenanceDate != null) {
      data['lastPeriodicMaintenanceDate'] =
          lastPeriodicMaintenanceDate.toString();
    }
    if (miles != null) data['milesLimit'] = miles;
    if (averageMilesPerMonth != null) {
      data['averageMilesPerMonth'] = averageMilesPerMonth;
    }
    return data;
  }

  Map<String, dynamic> toSignupJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sId != null) data['_id'] = sId;
    if (carType != null) data['carType'] = carType!.sId;
    data['plateNumber'] = plateNumber;
    data['year'] = year;
    if (carModel != null) data['carModel'] = carModel!.sId;
    if (color != null) data['color'] = color!.sId;
    data['owner'] = owner;
    if (iV != null) data['__v'] = iV;
    if (carLicenseRenewalDate != null) {
      data['carLicenseRenewalDate'] = carLicenseRenewalDate.toString();
    }
    if (lastPeriodicMaintenanceDate != null) {
      data['lastPeriodicMaintenanceDate'] =
          lastPeriodicMaintenanceDate.toString();
    }
    if (miles != null) data['miles'] = miles;
    if (averageMilesPerMonth != null) {
      data['averageMilesPerMonth'] = averageMilesPerMonth;
    }
    return data;
  }
}

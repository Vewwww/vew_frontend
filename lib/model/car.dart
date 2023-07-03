import 'car_model.dart';
import 'car_type.dart';
import 'name.dart';

class CarResponse {
  int? results;
  List<Car>? car;

  CarResponse({this.results, this.car});

  CarResponse.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    if (json['data'] != null) {
      car = <Car>[];
      json['data'].forEach((v) {
        car!.add(new Car.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results'] = this.results;
    if (this.car != null) {
      data['data'] = this.car!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

String? periodicMaintenanceNotification;

class Car {
  String? sId;
  CarType? carType;
  String? plateNumber;
  ColorData? color;
  String? owner;
  int? iV;
  CarModel? carModel;
  String? year;
  String? carLicenseRenewalDate;
  String? miles;
  //TODO::cast to double
  String? averageMilesPerMonth;
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
    if (json['carType'] is String)
      carType = CarType(sId: json['carType']);
    else
      carType = CarType.fromJson(json['carType']);

    plateNumber = json['plateNumber'];
    if (json['carType'] is String)
      color = ColorData(sId: json['color']);
    else
      color = ColorData.fromJson(json['color']);
    owner = json['owner'] ?? "";
    iV = json['__v'];
    if (json['carModel'] != null) {
      if (json['carModel'] is String)
        carModel = CarModel(sId: json['carModel']);
      else
        carModel = CarModel.fromJson(json['carModel']);
    }
    year = json['year'];
    carLicenseRenewalDate =
        json['CarLicenseRenewalDate'] ?? json['carLicenseRenewalNotifition'];
    miles = json['miles'];
    averageMilesPerMonth = json['averageMilesPerMonth'].toString();
    lastPeriodicMaintenanceDate = json['lastPeriodicMaintenanceDate'] ??
        json['periodicMaintenanceNotification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.carType != null) data['carType'] = this.carType!.toJson();
    data['plateNumber'] = this.plateNumber;
    if (this.color != null) data['color'] = this.color!.toJson();
    data['owner'] = this.owner;
    data['__v'] = this.iV;
    if (this.carModel != null) data['carModel'] = this.carModel!.toJson();
    data['year'] = this.year;
    data['CarLicenseRenewalDate'] = this.carLicenseRenewalDate;
    data['carLicenseRenewalNotifition'] = this.carLicenseRenewalDate;
    data['miles'] = this.miles;
    data['averageMilesPerMonth'] = this.averageMilesPerMonth;
    data['lastPeriodicMaintenanceDate'] = this.lastPeriodicMaintenanceDate;
    return data;
  }
}

class ColorData {
  Name? name;
  String? sId;
  String? code;

  ColorData({this.name, this.sId, this.code});

  ColorData.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    sId = json['_id'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    data['_id'] = this.sId;
    data['code'] = this.code;
    return data;
  }

  ColorData clone() => ColorData(code: this.code , name: this.name , sId: this.sId);
}

class AllCarsResponse {
  List<AllCars>? allCars;

  AllCarsResponse({this.allCars});

  AllCarsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      allCars = <AllCars>[];
      json['data'].forEach((v) {
        allCars!.add(AllCars.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (allCars != null) {
      data['data'] = allCars!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllCars {
  String? sId;
  String? carType;
  String? carModel;
  String? year;
  String? plateNumber;
  String? color;
  double? averageMilesPerMonth;
  String? lastPeriodicMaintenanceDate;
  String? owner;
  String? carLicenseRenewalNotifition;
  String? periodicMaintenanceNotification;
  int? iV;

  AllCars(
      {this.sId,
      this.carType,
      this.carModel,
      this.year,
      this.plateNumber,
      this.color,
      this.averageMilesPerMonth,
      this.lastPeriodicMaintenanceDate,
      this.owner,
      this.carLicenseRenewalNotifition,
      this.periodicMaintenanceNotification,
      this.iV});

  AllCars.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    carType = json['carType'];
    carModel = json['carModel'];
    year = json['year'];
    plateNumber = json['plateNumber'];
    color = json['color'];
    averageMilesPerMonth = json['averageMilesPerMonth']*1.0;
    lastPeriodicMaintenanceDate = json['lastPeriodicMaintenanceDate'];
    owner = json['owner'];
    carLicenseRenewalNotifition = json['carLicenseRenewalNotifition'];
    periodicMaintenanceNotification = json['periodicMaintenanceNotification'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['carType'] = carType;
    data['carModel'] = carModel;
    data['year'] = year;
    data['plateNumber'] = plateNumber;
    data['color'] = color;
    data['averageMilesPerMonth'] = averageMilesPerMonth;
    data['lastPeriodicMaintenanceDate'] = lastPeriodicMaintenanceDate;
    data['owner'] = owner;
    data['carLicenseRenewalNotifition'] = carLicenseRenewalNotifition;
    data['periodicMaintenanceNotification'] =
        periodicMaintenanceNotification;
    data['__v'] = iV;
    return data;
  }
}
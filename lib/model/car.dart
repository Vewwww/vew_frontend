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

class Car {
  String? sId;
  String? carType;
  String? plateNumber;
  String? color;
  String? owner;
  int? iV;
  String? carModel;
  String? year;
  String? carLicenseRenewalDate;
  String? miles;
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
    carType = json['carType'];
    plateNumber = json['plateNumber'];
    color = json['color'];
    owner = json['owner'];
    iV = json['__v'];
    carModel = json['carModel'];
    year = json['year'];
    carLicenseRenewalDate = json['CarLicenseRenewalDate'];
    miles = json['miles'];
    averageMilesPerMonth = json['averageMilesPerMonth'];
    lastPeriodicMaintenanceDate = json['lastPeriodicMaintenanceDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['carType'] = this.carType;
    data['plateNumber'] = this.plateNumber;
    data['color'] = this.color;
    data['owner'] = this.owner;
    data['__v'] = this.iV;
    data['carModel'] = this.carModel;
    data['year'] = this.year;
    data['CarLicenseRenewalDate'] = this.carLicenseRenewalDate;
    data['miles'] = this.miles;
    data['averageMilesPerMonth'] = this.averageMilesPerMonth;
    data['lastPeriodicMaintenanceDate'] = this.lastPeriodicMaintenanceDate;
    return data;
  }
}
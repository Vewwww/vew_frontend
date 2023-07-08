import 'dart:math';

import 'package:vewww/model/car.dart';

import 'car_type.dart';
import 'location.dart';
import 'name.dart';
import 'report.dart';
import 'services.dart';

abstract class Repairer {
  Name? name;
  Location? location;
  String? sId;
  String? phoneNumber;
  double? rate;
  int? ratesNumber;
  double? distance;

  Repairer.named({
    this.name,
    this.location,
    this.sId,
    this.phoneNumber,
    this.rate,
    this.ratesNumber,
    this.distance,
  });
  Repairer.fromJson(Map<String, dynamic> json, {bool isMechanic = false}) {
    print(json);
    // if (isMechanic) {
    //   name = Name(en: json['name']);
    // } else {
    //   name = json['name'] != null ? Name.fromJson(json['name']) : null;
    // }
    if (json['name'] != null) {
      name = (json['name'] is String)
          ? Name(en: json['name'])
          : Name.fromJson(json['name']);
    }
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    sId = json['_id'];
    if (json["distance"] != null) {
      print("dist : ${json['distance']}");
      distance = double.parse((json['distance']).toStringAsFixed(2));
    }
    phoneNumber = json['phoneNumber'];
    if (json['rate'] != null) rate = json['rate'] * 1.0;
    if (isMechanic) {
      ratesNumber = json['numOfRates'];
    } else {
      ratesNumber = json['ratesNumber'];
    }
  }
}

class MaintenanceCenter extends Repairer {
  List<CarType>? carType;
  bool? isVerified;
  int? iV;

  MaintenanceCenter(
      {name,
      location,
      sId,
      phoneNumber,
      this.carType,
      this.isVerified,
      rate,
      ratesNumber,
      this.iV})
      : super.named(
            name: name,
            location: location,
            phoneNumber: phoneNumber,
            rate: rate,
            ratesNumber: ratesNumber,
            sId: sId);

  MaintenanceCenter.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    sId = json['_id'];
    phoneNumber = json['phoneNumber'];
    if (json['carType'] != null) {
      carType = <CarType>[];
      json['carType'].forEach((v) {
        print(v.toString());
        carType!.add((v is String)
            ? CarType(sId: v)
            : (v is CarType)
                ? v
                : CarType.fromJson(v));
      });
    }
    isVerified = json['isVerified'];
    if (json['rate'] != null) rate = json['rate'] * 1.0;
    ratesNumber = json['ratesNumber'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) {
      data['name'] = name!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['_id'] = sId;
    data['phoneNumber'] = phoneNumber;
    if (carType != null) {
      data['carType'] = carType!.map((v) => v.toJson()).toList();
    }
    data['isVerified'] = isVerified;
    data['rate'] = rate;
    data['ratesNumber'] = ratesNumber;
    data['__v'] = iV;
    return data;
  }

  Map<String, dynamic> toAddJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) {
      data['name'] = name!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (sId != null) data['_id'] = sId;
    if (phoneNumber != null) data['phoneNumber'] = phoneNumber;
    if (carType != null) {
      data['carType'] = carType!.map((v) => v.sId).toList();
    }
    data['isVerified'] = isVerified ?? true;
    if (rate != null) data['rate'] = rate;
    if (ratesNumber != null) data['ratesNumber'] = ratesNumber;
    if (iV != null) data['__v'] = iV;
    return data;
  }
}

class Mechanic extends Repairer {
  Report? report;
  String? ownerName;
  String? email;
  String? password;
  String? mechanicPhone;
  String? mechanicName;
  bool? hasDelivery;
  List<Service>? service;
  bool? isSuspended;
  String? role;

  Mechanic(
      {this.report,
      location,
      sId,
      this.ownerName,
      this.email,
      this.password,
      this.mechanicPhone,
      name,
      phoneNumber,
      this.hasDelivery,
      this.service,
      rate,
      numOfRates,
      this.isSuspended,
      this.role})
      : super.named(
            location: location,
            name: Name(en: name),
            phoneNumber: phoneNumber,
            rate: rate,
            ratesNumber: numOfRates,
            sId: sId);

  Mechanic.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    report = json['report'] != null ? Report.fromJson(json['report']) : null;
    ownerName = json['ownerName'];
    email = json['email'];
    password = json['password'];
    mechanicPhone = json['mechanicPhone'];

    hasDelivery = json['hasDelivery'];
    if (json['service'] != null) {
      service = <Service>[];
      json['service'].forEach((v) {
        service!.add(Service.fromJson(v));
      });
    }
    isSuspended = json['isSuspended'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (report != null) {
      data['report'] = report!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['_id'] = sId;
    data['ownerName'] = ownerName;
    data['email'] = email;
    data['password'] = password;
    data['mechanicPhone'] = mechanicPhone;
    if (name != null)
      data['name'] = name!.toJson();
    else {}
    data['phoneNumber'] = phoneNumber;
    data['hasDelivery'] = hasDelivery;
    if (service != null) {
      data['service'] = service!.map((v) => v.toJson()).toList();
    }
    data['rate'] = rate;
    data['numOfRates'] = ratesNumber;
    data['isSuspended'] = isSuspended;
    data['role'] = role;
    return data;
  }
}

class GasStation extends Repairer {
  int? iV;

  GasStation({name, location, sId, this.iV})
      : super.named(name: name, location: location, sId: sId);

  GasStation.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) {
      data['name'] = name!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['_id'] = sId;
    data['__v'] = iV;
    return data;
  }
}

class Place extends Repairer {
  List<CarType>? carType;
  bool? isVerified;
  int? iV;
  Report? report;
  String? ownerName;
  String? email;
  String? password;
  String? mechanicPhone;
  bool? hasDelivery;
  List<Service>? service;
  bool? isSuspended;
  String? role;

  Place(
      {name,
      location,
      sId,
      phoneNumber,
      this.carType,
      this.isVerified,
      this.email,
      this.hasDelivery,
      this.isSuspended,
      this.mechanicPhone,
      this.ownerName,
      this.password,
      this.report,
      this.role,
      this.service,
      rate,
      distance,
      ratesNumber,
      this.iV})
      : super.named(
            name: name,
            location: location,
            sId: sId,
            phoneNumber: phoneNumber,
            rate: rate,
            distance: distance,
            ratesNumber: ratesNumber);

  Place.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    if (json['carType'] != null) {
      if (json['carType'].length > 0 && json['carType'][0] is String) {
        carType = [];
        json['carType'].forEach((v) {
          carType!.add(CarType(sId: v));
        });
      } else {
        carType = <CarType>[];
        json['carType'].forEach((v) {
          carType!.add(CarType.fromJson(v));
        });
      }
    }
    isVerified = json['isVerified'];
    iV = json['__v'];
    ownerName = json['ownerName'];
    email = json['email'];
    if (json["name"] != null)
      name = (json["name"] is String)
          ? Name(ar: json["name"], en: json["name"])
          : Name.fromJson(json["name"]);
    password = json['password'];
    mechanicPhone = json['mechanicPhone'];
    hasDelivery = json['hasDelivery'];
    role = json['role'];
    if (json['service'] != null) {
      if (json['service'][0] != null && json['service'][0] is String) {
        service = [];
        json['service'].forEach((v) {
          service!.add(Service(sId: v));
        });
      } else {
        service = <Service>[];
        json['service'].forEach((v) {
          service!.add(Service.fromJson(v));
        });
      }
    }
    isSuspended = json['isSuspended'];
    report =
        json['report'] != null ? new Report.fromJson(json['report']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) {
      data['name'] = name!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    } else {
      print("location null");
    }
    data['_id'] = sId;
    if (phoneNumber != null) data['phoneNumber'] = phoneNumber;
    if (distance != null) data['distance'] = distance;
    if (carType != null) data['carType'] = carType;
    if (isVerified != null) data['isVerified'] = isVerified;
    if (rate != null) data['rate'] = rate;
    if (ratesNumber != null) data['ratesNumber'] = ratesNumber;
    if (iV != null) data['__v'] = iV;
    if (ownerName != null) data['ownerName'] = ownerName;
    if (email != null) data['email'] = email;
    if (password != null) data['password'] = password;
    if (mechanicPhone != null) data['mechanicPhone'] = mechanicPhone;
    if (hasDelivery != null) data['hasDelivery'] = hasDelivery;
    if (role != null) data['role'] = role;
    if (service != null) {
      List<Map<String, dynamic>> x = [];
      for (var s in service!) {
        x.add(s.toJson());
      }
      data['service'] = x;
    }
    if (isSuspended != null) data['isSuspended'] = isSuspended;
    return data;
  }
}

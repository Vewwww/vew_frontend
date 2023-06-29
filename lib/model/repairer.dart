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

  Repairer.named({
    this.name,
    this.location,
    this.sId,
    this.phoneNumber,
    this.rate,
    this.ratesNumber,
  });
  Repairer.fromJson(Map<String, dynamic> json, {bool isMechanic = false}) {
    if (isMechanic) {
      name = Name(en: json['name']);
    } else {
      name = json['name'] != null ? Name.fromJson(json['name']) : null;
    }
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    sId = json['_id'];
    phoneNumber = json['phoneNumber'];
    //print("object 111 ${json['rate']}");
    if (json['rate'] != null) rate = json['rate'] * 1.0;
    if (isMechanic)
      ratesNumber = json['numOfRates'];
    else
      ratesNumber = json['ratesNumber'];
  }
}

class MaintenanceCenter extends Repairer {
  List<CarType>? carType;
  bool? isVerified;
  //TODO::ask back about  iv meaning
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
    //print("here 14");
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    //print("here 13");
    sId = json['_id'];
    //print("here 12");
    phoneNumber = json['phoneNumber'];
    if (json['carType'] != null) {
      carType = <CarType>[];
      json['carType'].forEach((v) {
        carType!.add(CarType.fromJson(v));
      });
    }
    isVerified = json['isVerified'];
    //print("here 11");
    rate = json['rate'] * 1.0;
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

  Mechanic.fromJson(Map<String, dynamic> json)
      : super.fromJson(json, isMechanic: true) {
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
    data['name'] = name!.en!;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}

class Place extends Repairer {
  List<String>? carType;
  bool? isVerified;
  int? iV;

  Place(
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
            sId: sId,
            phoneNumber: phoneNumber,
            rate: rate,
            ratesNumber: ratesNumber);

  Place.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    if (json['carType'] != null) {
      carType = <String>[];
      json['carType'].forEach((v) {
        carType!.add(v);
      });
    }
    isVerified = json['isVerified'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['_id'] = this.sId;
    data['phoneNumber'] = this.phoneNumber;
    data['carType'] = this.carType;
    data['isVerified'] = this.isVerified;
    data['rate'] = this.rate;
    data['ratesNumber'] = this.ratesNumber;
    data['__v'] = this.iV;
    return data;
  }
}

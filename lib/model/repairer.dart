import 'car_type.dart';
import 'location.dart';

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
  Repairer.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    sId = json['_id'];
    phoneNumber = json['phoneNumber'];
    //print("object 111 ${json['rate']}");
    rate = json['rate'] * 1.0;
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

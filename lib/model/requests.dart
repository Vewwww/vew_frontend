import 'package:vewww/model/car_type.dart';
//import 'package:vewww/model/location.dart';
import 'package:vewww/model/name.dart';

class PreviousRequestResponse {
  List<PreviousRequest>? previousRequests;

  PreviousRequestResponse({this.previousRequests});

  PreviousRequestResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      previousRequests = <PreviousRequest>[];
      json['data'].forEach((v) {
        previousRequests!.add(new PreviousRequest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.previousRequests != null) {
      data['data'] =
          this.previousRequests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PreviousRequest {
  Location? location;
  String? sId;
  Driver? driver;
  Car? car;
  Mechanic? mechanic;
  String? createdAt;
  bool? isWinch;
  Winch? winch;

  PreviousRequest(
      {this.location,
      this.sId,
      this.driver,
      this.car,
      this.mechanic,
      this.createdAt,
      this.isWinch,
      this.winch});

  PreviousRequest.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    driver =
        json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
    car = json['car'] != null ? new Car.fromJson(json['car']) : null;
    mechanic = json['mechanic'] != null
        ? new Mechanic.fromJson(json['mechanic'])
        : null;
    createdAt = json['created_at'];
    isWinch = json['isWinch'];
    winch = json['winch'] != null ? new Winch.fromJson(json['winch']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['_id'] = this.sId;
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    if (this.car != null) {
      data['car'] = this.car!.toJson();
    }
    if (this.mechanic != null) {
      data['mechanic'] = this.mechanic!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['isWinch'] = this.isWinch;
    if (this.winch != null) {
      data['winch'] = this.winch!.toJson();
    }
    return data;
  }
}

class Location {
  String? road;
  double? latitude;
  double? longitude;

  Location({this.road, this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    road = json['road'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['road'] = this.road;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class Driver {
  String? sId;
  String? name;

  Driver({this.sId, this.name});

  Driver.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}

class Car {
  String? sId;
  CarType? carType;
  String? plateNumber;
  Color? color;
  int? iV;

  Car({this.sId, this.carType, this.plateNumber, this.color, this.iV});

  Car.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    carType =
        json['carType'] != null ? new CarType.fromJson(json['carType']) : null;
    plateNumber = json['plateNumber'];
    color = json['color'] != null ? new Color.fromJson(json['color']) : null;
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.carType != null) {
      data['carType'] = this.carType!.toJson();
    }
    data['plateNumber'] = this.plateNumber;
    if (this.color != null) {
      data['color'] = this.color!.toJson();
    }
    data['__v'] = this.iV;
    return data;
  }
}

// class CarType {
//   Name? name;
//   String? sId;

//   CarType({this.name, this.sId});

//   CarType.fromJson(Map<String, dynamic> json) {
//     name = json['name'] != null ? new Name.fromJson(json['name']) : null;
//     sId = json['_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.name != null) {
//       data['name'] = this.name!.toJson();
//     }
//     data['_id'] = this.sId;
//     return data;
//   }
// }

// class Name {
//   String? ar;
//   String? en;

//   Name({this.ar, this.en});

//   Name.fromJson(Map<String, dynamic> json) {
//     ar = json['ar'];
//     en = json['en'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['ar'] = this.ar;
//     data['en'] = this.en;
//     return data;
//   }
// }

class Color {
  Name? name;
  String? sId;
  String? code;

  Color({this.name, this.sId, this.code});

  Color.fromJson(Map<String, dynamic> json) {
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
}

class Mechanic {
  String? sId;
  String? name;
  double? rate;
  String? service;

  Mechanic({this.sId, this.name, this.rate, this.service});

  Mechanic.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    rate = json['rate'];
    service = json['service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['rate'] = this.rate;
    data['service'] = this.service;
    return data;
  }
}

class Winch {
  String? sId;
  String? name;
  double? rate;
  String? plateNumber;

  Winch({this.sId, this.name, this.rate, this.plateNumber});

  Winch.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    rate = json['rate']*1.0;
    plateNumber = json['plateNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['rate'] = this.rate;
    data['plateNumber'] = this.plateNumber;
    return data;
  }
}
import 'package:vewww/model/car_model.dart';
import 'package:vewww/model/car_type.dart';
import 'package:vewww/model/location.dart';
import 'package:vewww/model/services.dart';

import 'car_color.dart';

class RequestResponse {
  List<Request>? previousRequests;

  RequestResponse({this.previousRequests});

  RequestResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      previousRequests = <Request>[];
      json['data'].forEach((v) {
        previousRequests!.add(Request.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (previousRequests != null) {
      data['data'] = previousRequests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CreateRequest {
  String? driver;
  String? car;
  Location? location;
  String? winch;
  String? mechanic;
  String? service;

  CreateRequest(
      {this.driver,
      this.car,
      this.location,
      this.winch,
      this.mechanic,
      this.service});

  CreateRequest.fromJson(Map<String, dynamic> json) {
    driver = json['driver'];
    car = json['car'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    winch = json['winch'];
    mechanic = json['mechanic'];
    service = json['service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['driver'] = driver;
    data['car'] = car;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['winch'] = winch;
    data['mechanic'] = mechanic;
    data['service'] = service;
    return data;
  }

  Future<Map<String, dynamic>> toJsonRequest()  async{
    final Map<String, dynamic> data = <String, dynamic>{};
    data['driver'] = driver;
    data['car'] = car;
    if (location != null) {
      data['location'] = await location!.toJsonRequest();
    }
    if (winch != null) data['winch'] = winch;
    if (mechanic != null) data['mechanic'] = mechanic;
    if (service != null) data['service'] = service;
    return data;
  }
}

class Request {
  Location? location;
  String? sId;
  Driver? driver;
  Car? car;
  Service? service;
  Mechanic? mechanic;
  String? createdAt;
  bool? isWinch;
  Winch? winch;
  Request(
      {this.location,
      this.sId,
      this.driver,
      this.car,
      this.service,
      this.mechanic,
      this.createdAt,
      this.isWinch,
      this.winch});

  Request.fromJson(Map<String, dynamic> json) {
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    sId = json['_id'];
    driver = json['driver'] != null ? Driver.fromJson(json['driver']) : null;
    service =
        json['service'] != null ? Service.fromJson(json['service']) : null;
    car = json['car'] != null ? Car.fromJson(json['car']) : null;
    mechanic =
        json['mechanic'] != null ? Mechanic.fromJson(json['mechanic']) : null;
    createdAt = json['created_at'];
    isWinch = json['isWinch'] ?? false;
    winch = json['winch'] != null ? Winch.fromJson(json['winch']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['_id'] = sId;
    if (driver != null) {
      data['driver'] = driver!.toJson();
    }
    if (car != null) {
      data['car'] = car!.toJson();
    }
    if (mechanic != null) {
      data['mechanic'] = mechanic!.toJson();
    }
    data['created_at'] = createdAt;
    data['isWinch'] = isWinch;
    if (winch != null) {
      data['winch'] = winch!.toJson();
    }
    return data;
  }
}

class Driver {
  String? sId;
  String? name;
  String? phoneNumber;

  Driver({this.sId, this.name, this.phoneNumber});

  Driver.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
  }

  get person => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}

class Car {
  String? sId;
  CarType? carType;
  CarModel? carModel;
  String? plateNumber;
  CarColor? color;
  int? iV;

  Car(
      {this.sId,
      this.carType,
      this.plateNumber,
      this.color,
      this.iV,
      this.carModel});

  Car.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    carType =
        json['carType'] != null ? CarType.fromJson(json['carType']) : null;
    carModel =
        json['carModel'] != null ? CarModel.fromJson(json['carModel']) : null;
    plateNumber = json['plateNumber'];
    color = json['color'] != null ? CarColor.fromJson(json['color']) : null;
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (carType != null) {
      data['carType'] = carType!.toJson();
    }
    data['carModel'] = carModel;
    data['plateNumber'] = plateNumber;
    if (color != null) {
      data['color'] = color!.toJson();
    }
    data['__v'] = iV;
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
    rate = json['rate'] * 1.0;
    service = json['service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['rate'] = rate;
    data['service'] = service;
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
    rate = json['rate'] * 1.0;
    plateNumber = json['plateNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['rate'] = rate;
    data['plateNumber'] = plateNumber;
    return data;
  }
}

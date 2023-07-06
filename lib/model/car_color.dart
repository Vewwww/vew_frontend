import 'package:flutter/material.dart';
import 'name.dart';

class CarColorResponse {
  int? results;
  List<CarColor>? carColor;

  CarColorResponse({this.results, this.carColor});

  CarColorResponse.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    if (json['data'] != null) {
      carColor = <CarColor>[];
      json['data'].forEach((v) {
        carColor!.add(CarColor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results;
    if (carColor != null) {
      data['data'] = carColor!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CarColor {
  Name? name;
  String? sId;
  Color? code;
  int? iV;

  CarColor({this.name, this.sId, this.code, this.iV});

  CarColor.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    sId = json['_id'];
    var codeString = json['code'];
    var hexColor = codeString.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      code = Color(int.parse("0x$hexColor"));
    }
    if (json['__v'] != null) iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['_id'] = sId;
    data['code'] = code;
    data['__v'] = iV;
    return data;
  }

  CarColor clone() =>
      CarColor(code: code, name: name, sId: sId, iV: iV);
}

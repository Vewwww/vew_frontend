import 'package:flutter/material.dart';

class CarColorResponse {
  int? results;
  List<CarColor>? carColor;

  CarColorResponse({this.results, this.carColor});

  CarColorResponse.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    if (json['data'] != null) {
      carColor = <CarColor>[];
      json['data'].forEach((v) {
        carColor!.add(new CarColor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results'] = this.results;
    if (this.carColor != null) {
      data['data'] = this.carColor!.map((v) => v.toJson()).toList();
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
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    sId = json['_id'];
    var codeString = json['code'];
    var hexColor = codeString.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      code = Color(int.parse("0x$hexColor"));
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    data['_id'] = this.sId;
    data['code'] = this.code;
    data['__v'] = this.iV;
    return data;
  }
}

class Name {
  String? en;
  String? ar;

  Name({this.en, this.ar});

  Name.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['ar'] = this.ar;
    return data;
  }
}

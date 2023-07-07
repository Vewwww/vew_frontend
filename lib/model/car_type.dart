import 'name.dart';

class CarTypeResponse {
  int? results;
  List<CarType>? carType;

  CarTypeResponse({this.results, this.carType});

  CarTypeResponse.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    if (json['data'] != null) {
      carType = <CarType>[];
      json['data'].forEach((v) {
        carType!.add(CarType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results;
    if (carType != null) {
      data['data'] = carType!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CarType {
  Name? name;
  String? sId;
  int? iV;

  CarType({this.name, this.sId, this.iV});

  CarType.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['_id'] = sId;
    data['__v'] = iV;
    return data;
  }

  CarType clone() {
    return CarType(iV: iV , name: name , sId: sId);
  }
}


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
        carType!.add(new CarType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results'] = this.results;
    if (this.carType != null) {
      data['data'] = this.carType!.map((v) => v.toJson()).toList();
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
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }

  CarType clone() {
    return CarType(iV: this.iV , name: this.name , sId: this.sId);
  }
}


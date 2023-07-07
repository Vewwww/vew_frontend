import 'name.dart';

class ServiceResponse {
  int? results;
  List<Service>? service;

  ServiceResponse({this.results, this.service});

  ServiceResponse.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    if (json['data'] != null) {
      service = <Service>[];
      json['data'].forEach((v) {
        service!.add(Service.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results;
    if (service != null) {
      data['data'] = service!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Service {
  Name? name;
  String? sId;
  int? iV;

  Service({this.name, this.sId, this.iV});

  Service.fromJson(Map<String, dynamic> json) {
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
}

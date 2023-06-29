import 'name.dart';

class SignResponse {
  int? results;
  List<Sign>? signs;

  SignResponse({this.results, this.signs});

  SignResponse.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    if (json['data'] != null) {
      signs = <Sign>[];
      json['data'].forEach((v) {
        signs!.add(Sign.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['results'] = this.results;
    if (this.signs != null) {
      data['data'] = this.signs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sign {
  Name? name;
  Name? description;
  Name? solution;
  String? sId;
  String? image;
  int? iV;

  Sign(
      {this.name,
      this.description,
      this.solution,
      this.sId,
      this.image,
      this.iV});

  Sign.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    description = json['description'] != null
        ? Name.fromJson(json['description'])
        : null;
    solution =
        json['solution'] != null ? Name.fromJson(json['solution']) : null;
    sId = json['_id'];
    image = json['image'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    if (this.description != null) {
      data['description'] = this.description!.toJson();
    }
    if (this.solution != null) {
      data['solution'] = this.solution!.toJson();
    }
    data['_id'] = this.sId;
    data['image'] = this.image;
    data['__v'] = this.iV;
    return data;
  }
}



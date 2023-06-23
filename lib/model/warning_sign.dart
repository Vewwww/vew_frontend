class SignResponse {
  Name? name;
  Name? description;
  Name? solution;
  String? sId;
  String? image;
  int? iV;

  SignResponse(
      {this.name,
      this.description,
      this.solution,
      this.sId,
      this.image,
      this.iV});

  SignResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    description = json['description'] != null
        ? new Name.fromJson(json['description'])
        : null;
    solution =
        json['solution'] != null ? new Name.fromJson(json['solution']) : null;
    sId = json['_id'];
    image = json['image'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
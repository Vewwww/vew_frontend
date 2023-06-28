class CarModelResponse {
  List<CarModel>? carModels;

  CarModelResponse({this.carModels});

  CarModelResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      carModels = <CarModel>[];
      json['data'].forEach((v) {
        carModels!.add(new CarModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.carModels != null) {
      data['data'] = this.carModels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CarModel {
  String? sId;
  String? name;
  String? brand;
  int? iV;

  CarModel({this.sId, this.name, this.brand, this.iV});

  CarModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    brand = json['brand'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['brand'] = this.brand;
    data['__v'] = this.iV;
    return data;
  }
}

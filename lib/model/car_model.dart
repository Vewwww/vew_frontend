class CarModelResponse {
  List<CarModel>? carModels;

  CarModelResponse({this.carModels});

  CarModelResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      carModels = <CarModel>[];
      json['data'].forEach((v) {
        carModels!.add(CarModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (carModels != null) {
      data['data'] = carModels!.map((v) => v.toJson()).toList();
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
  CarModel clone(){
    return CarModel(brand: brand , name: name , iV: iV , sId: sId);
  }

  CarModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    brand = json['brand'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['brand'] = brand;
    data['__v'] = iV;
    return data;
  }
}

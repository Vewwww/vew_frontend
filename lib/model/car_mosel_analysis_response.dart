class CarModelAnalysisResponse {
  String? model;
  String? brand;

  CarModelAnalysisResponse({this.model, this.brand});

  CarModelAnalysisResponse.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    brand = json['brand'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['model'] = model;
    data['brand'] = brand;
    return data;
  }
}

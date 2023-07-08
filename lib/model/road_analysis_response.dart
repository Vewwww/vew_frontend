class RoadAnalysisResponse {
  String? name;
  int? value;

  RoadAnalysisResponse({this.name, this.value});

  RoadAnalysisResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}

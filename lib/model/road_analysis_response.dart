class RoadAnalysisResponse {
  String? name;
  int? value;

  RoadAnalysisResponse({this.name, this.value});

  RoadAnalysisResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}

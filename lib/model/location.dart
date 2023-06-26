import 'name.dart';

class Location {
  Name? description;
  double? latitude;
  double? longitude;

  Location({this.description, this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    description = json['description'] != null
        ? Name.fromJson(json['description'])
        : null;
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.description != null) {
      data['description'] = this.description!.toJson();
    }
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}



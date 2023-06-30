import 'name.dart';

class Location {
  Name? description;
  double? latitude;
  double? longitude;

  Location({this.description, this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    description =
        json['description'] != null ? Name.fromJson(json['description']) : null;
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (description != null) {
      data['description'] = description!.toJson();
    }
    if (latitude != null) data['latitude'] = latitude;
    if (longitude != null) data['longitude'] = longitude;
    return data;
  }
}

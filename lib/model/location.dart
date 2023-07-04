import 'name.dart';

class Location {
  Name? description;
  double? latitude;
  double? longitude;

  Location({this.description, this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    description = json['description'] != null
        ? json['description'] is String
            ? Name(ar: json['description'], en: json['description'])
            : Name.fromJson(json['description'])
        : description = json['road'] != null
            ? json['road'] is String
                ? Name(ar: json['road'], en: json['road'])
                : Name.fromJson(json['road'])
            : null;
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
  Map<String, dynamic> toJsonRequest() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (description != null) {
      data['road'] = description!.en;
    }
    if (latitude != null) data['latitude'] = latitude;
    if (longitude != null) data['longitude'] = longitude;
    return data;
  }
}

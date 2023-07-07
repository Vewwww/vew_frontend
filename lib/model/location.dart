import 'package:geocoding/geocoding.dart';
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
    if (json['latitude'] != null) latitude = json['latitude'] * 1.0;
    if (json['longitude'] != null) longitude = json['longitude'] * 1.0;
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

  Future<Map<String, dynamic>> toJsonRequest() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (latitude != null && longitude != null) {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude!, longitude!);
      Placemark address = placemarks[0];
      data['road'] = address.street;
    }
    if (latitude != null) data['latitude'] = latitude;
    if (longitude != null) data['longitude'] = longitude;
    return data;
  }
}

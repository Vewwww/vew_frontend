import 'location.dart';
import 'name.dart';
import 'repairer.dart';

class NearesetPlaceResponse {
  int? results;
  List<Place>? places;

  NearesetPlaceResponse({this.results, this.places});

  NearesetPlaceResponse.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    if (json['data'] != null) {
      places = <Place>[];
      json['data'].forEach((v) {
        places!.add(new Place.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results'] = this.results;
    if (this.places != null) {
      data['data'] = this.places!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

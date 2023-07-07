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
        places!.add(Place.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results;
    if (places != null) {
      data['data'] = places!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

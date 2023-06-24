import 'location.dart';

class NearesetGasStationResponse {
  int? results;
  List<GasStation>? gasStation;

  NearesetGasStationResponse({this.results, this.gasStation});

  NearesetGasStationResponse.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    if (json['data'] != null) {
      gasStation = <GasStation>[];
      json['data'].forEach((v) {
        gasStation!.add(new GasStation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results'] = this.results;
    if (this.gasStation != null) {
      data['data'] = this.gasStation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GasStation {
  Location? location;
  String? sId;
  int? iV;

  GasStation({this.location, this.sId, this.iV});

  GasStation.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ?  Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['_id'] = sId;
    data['__v'] = iV;
    return data;
  }
}

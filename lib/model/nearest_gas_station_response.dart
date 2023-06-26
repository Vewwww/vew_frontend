import 'package:vewww/model/repairer.dart';

class NearesetGasStationResponse {
  int? results;
  List<GasStation>? gasStations;

  NearesetGasStationResponse({this.results, this.gasStations});

  NearesetGasStationResponse.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    if (json['data'] != null) {
      gasStations = <GasStation>[];
      json['data'].forEach((v) {
        gasStations!.add(GasStation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results;
    if (gasStations != null) {
      data['data'] = gasStations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


import 'package:vewww/model/repairer.dart';

import 'car_type.dart';
import 'location.dart';

class NearesetMCResponse {
  int? results;
  List<MaintenanceCenter>? maintenanceCenter;

  NearesetMCResponse({this.results, this.maintenanceCenter});

  NearesetMCResponse.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    if (json['data'] != null) {
      maintenanceCenter = <MaintenanceCenter>[];
      json['data'].forEach((v) {
        print(v);
        maintenanceCenter!.add(MaintenanceCenter.fromJson(v));
        print("added");
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results;
    if (maintenanceCenter != null) {
      data['data'] = maintenanceCenter!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

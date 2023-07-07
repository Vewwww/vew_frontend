import 'repairer.dart';

class NearestMechanicResponse{
  int? results;
  List<Mechanic>? mechanic;

  NearestMechanicResponse({this.results, this.mechanic});

  NearestMechanicResponse.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    if (json['data'] != null) {
      mechanic = <Mechanic>[];
      json['data'].forEach((v) {
        mechanic!.add(Mechanic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results;
    if (mechanic != null) {
      data['data'] = mechanic!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}




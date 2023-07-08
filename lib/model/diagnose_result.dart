import 'package:vewww/model/services.dart';

class DiagnoseResult {
  String? sId;
  List<String>? caseKeyWords;
  String? solution;
  Service? serviceId;
  int? iV;
  bool? gasStation;
  bool? maintenanceCenter;
  bool? mechanic;

  DiagnoseResult(
      {this.sId,
      this.caseKeyWords,
      this.solution,
      this.serviceId,
      this.iV,
      this.gasStation,
      this.maintenanceCenter,
      this.mechanic});

  DiagnoseResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    caseKeyWords = json['caseKeyWords'].cast<String>();
    solution = json['solution'];
    serviceId = json['serviceId'] != null
        ? Service.fromJson(json['serviceId'])
        : null;
    iV = json['__v'];
    gasStation = json['gasStation'];
    maintenanceCenter = json['maintenanceCenter'];
    mechanic = json['mechanic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['caseKeyWords'] = caseKeyWords;
    data['solution'] = solution;
    if (serviceId != null) {
      data['serviceId'] = serviceId!.toJson();
    }
    data['__v'] = iV;
    data['gasStation'] = gasStation;
    data['maintenanceCenter'] = maintenanceCenter;
    data['mechanic'] = mechanic;
    return data;
  }
}


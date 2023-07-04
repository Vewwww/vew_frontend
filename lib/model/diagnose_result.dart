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
        ? new Service.fromJson(json['serviceId'])
        : null;
    iV = json['__v'];
    gasStation = json['gasStation'];
    maintenanceCenter = json['maintenanceCenter'];
    mechanic = json['mechanic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['caseKeyWords'] = this.caseKeyWords;
    data['solution'] = this.solution;
    if (this.serviceId != null) {
      data['serviceId'] = this.serviceId!.toJson();
    }
    data['__v'] = this.iV;
    data['gasStation'] = this.gasStation;
    data['maintenanceCenter'] = this.maintenanceCenter;
    data['mechanic'] = this.mechanic;
    return data;
  }
}


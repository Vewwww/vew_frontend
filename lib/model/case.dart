class Case {
  List<String>? caseKeyWords;
  String? solution;
  String? serviceId;
  bool? maintenanceCenter;
  bool? mechanic;
  bool? gasStation;

  Case(
      {this.caseKeyWords,
      this.solution,
      this.serviceId,
      this.maintenanceCenter,
      this.mechanic,
      this.gasStation});

  Case.fromJson(Map<String, dynamic> json) {
    caseKeyWords = json['caseKeyWords'].cast<String>();
    solution = json['solution'];
    if( json['serviceId'] != null)serviceId = json['serviceId'];
    maintenanceCenter = json['maintenanceCenter'];
    mechanic = json['mechanic'];
    gasStation = json['gasStation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['caseKeyWords'] = caseKeyWords;
    data['solution'] = solution;
    if(serviceId !=null) data['serviceId'] =serviceId;
    data['maintenanceCenter'] =maintenanceCenter;
    data['mechanic'] = mechanic;
    data['gasStation'] = gasStation;
    return data;
  }
}
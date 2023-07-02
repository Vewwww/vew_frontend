class NearestWinchResponse {
  int? results;
  List<NearestWinch>? nearestWinch;

  NearestWinchResponse({this.results, this.nearestWinch});

  NearestWinchResponse.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    if (json['data'] != null) {
      nearestWinch = <NearestWinch>[];
      json['data'].forEach((v) {
        nearestWinch!.add(new NearestWinch.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results'] = this.results;
    if (this.nearestWinch != null) {
      data['data'] = this.nearestWinch!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NearestWinch {
  Report? report;
  Location? location;
  String? sId;
  String? name;
  String? email;
  String? password;
  String? phoneNumber;
  double? rate;
  int? numOfRates;
  bool? isSuspended;
  String? role;
  String? plateNumber;
  bool? available;
  double? distance;

  NearestWinch(
      {this.report,
      this.location,
      this.sId,
      this.name,
      this.email,
      this.password,
      this.phoneNumber,
      this.rate,
      this.numOfRates,
      this.isSuspended,
      this.role,
      this.plateNumber,
      this.available,
      this.distance});

  NearestWinch.fromJson(Map<String, dynamic> json) {
    report =
        json['report'] != null ? new Report.fromJson(json['report']) : null;
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    rate = json['rate']*1.0;
    numOfRates = json['numOfRates'];
    isSuspended = json['isSuspended'];
    role = json['role'];
    plateNumber = json['plateNumber'];
    available = json['available'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.report != null) {
      data['report'] = this.report!.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phoneNumber'] = this.phoneNumber;
    data['rate'] = this.rate;
    data['numOfRates'] = this.numOfRates;
    data['isSuspended'] = this.isSuspended;
    data['role'] = this.role;
    data['plateNumber'] = this.plateNumber;
    data['available'] = this.available;
    data['distance'] = this.distance;
    return data;
  }
}

class Report {
  int? reportsNumber;
  String? dateReport;

  Report({this.reportsNumber, this.dateReport});

  Report.fromJson(Map<String, dynamic> json) {
    reportsNumber = json['reportsNumber'];
    dateReport = json['dateReport'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reportsNumber'] = this.reportsNumber;
    data['dateReport'] = this.dateReport;
    return data;
  }
}

class Location {
  double? latitude;
  double? longitude;

  Location({this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
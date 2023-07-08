class NearestWinchResponse {
  int? results;
  List<NearestWinch>? nearestWinch;

  NearestWinchResponse({this.results, this.nearestWinch});

  NearestWinchResponse.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    if (json['data'] != null) {
      nearestWinch = <NearestWinch>[];
      json['data'].forEach((v) {
        nearestWinch!.add(NearestWinch.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results;
    if (nearestWinch != null) {
      data['data'] = nearestWinch!.map((v) => v.toJson()).toList();
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
        json['report'] != null ? Report.fromJson(json['report']) : null;
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    if(json['rate'] != null)rate = json['rate']*1.0;
    numOfRates = json['numOfRates'];
    isSuspended = json['isSuspended'];
    role = json['role'];
    plateNumber = json['plateNumber'];
    available = json['available'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (report != null) {
      data['report'] = report!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['phoneNumber'] = phoneNumber;
    data['rate'] = rate;
    data['numOfRates'] = numOfRates;
    data['isSuspended'] = isSuspended;
    data['role'] = role;
    data['plateNumber'] = plateNumber;
    data['available'] = available;
    data['distance'] = distance;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reportsNumber'] = reportsNumber;
    data['dateReport'] = dateReport;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
class UserAnalysisResponse {
  int? numOfAllUsers;
  double? numOfMechanists;
  double? numOfWinches;
  double? numOfDrivers;

  UserAnalysisResponse(
      {this.numOfAllUsers,
      this.numOfMechanists,
      this.numOfWinches,
      this.numOfDrivers});

  UserAnalysisResponse.fromJson(Map<String, dynamic> json) {
    numOfAllUsers = json['numOfAllUsers'];
    numOfMechanists = json['numOfMechanists'] * 1.0;
    numOfWinches = json['numOfWinches'] * 1.0;
    numOfDrivers = json['numOfDrivers'] * 1.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['numOfAllUsers'] = numOfAllUsers;
    data['numOfMechanists'] = numOfMechanists;
    data['numOfWinches'] = numOfWinches;
    data['numOfDrivers'] = numOfDrivers;
    return data;
  }
}

class GenderAnalysisResponse {
  double? maleRatio;
  double? femaleRatio;

  GenderAnalysisResponse({this.maleRatio, this.femaleRatio});

  GenderAnalysisResponse.fromJson(Map<String, dynamic> json) {
    maleRatio = json['maleRatio'] * 1.0;
    femaleRatio = json['femaleRatio'] * 1.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maleRatio'] = maleRatio;
    data['femaleRatio'] = femaleRatio;
    return data;
  }
}

class SeasonAnalysisResponse {
  Season? season;

  SeasonAnalysisResponse({this.season});

  SeasonAnalysisResponse.fromJson(Map<String, dynamic> json) {
    season = json['data'] != null ? Season.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (season != null) {
      data['data'] = season!.toJson();
    }
    return data;
  }
}

class Season {
  double? summer;
  double? winter;
  double? autumn;
  double? spring;

  Season({this.summer, this.winter, this.autumn, this.spring});

  Season.fromJson(Map<String, dynamic> json) {
    if (json['summer'] != null) summer = json['summer'] * 1.0;
    if (json['winter'] != null) winter = json['winter'] * 1.0;
    if (json['autumn'] != null) autumn = json['autumn'] * 1.0;
    if (json['spring'] != null) spring = json['spring'] * 1.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['summer'] = summer;
    data['winter'] = winter;
    data['autumn'] = autumn;
    data['spring'] = spring;
    return data;
  }
}

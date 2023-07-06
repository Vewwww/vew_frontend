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
    numOfMechanists = json['numOfMechanists']*1.0;
    numOfWinches = json['numOfWinches']*1.0;
    numOfDrivers = json['numOfDrivers']*1.0;
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
    maleRatio = json['maleRatio']*1.0;
    femaleRatio = json['femaleRatio']*1.0;
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
  int? summer;
  int? winter;
  int? autumn;
  int? spring;

  Season({this.summer, this.winter, this.autumn, this.spring});

  Season.fromJson(Map<String, dynamic> json) {
    summer = json['summer'];
    winter = json['winter'];
    autumn = json['autumn'];
    spring = json['spring'];
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
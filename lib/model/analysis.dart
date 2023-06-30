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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['numOfAllUsers'] = this.numOfAllUsers;
    data['numOfMechanists'] = this.numOfMechanists;
    data['numOfWinches'] = this.numOfWinches;
    data['numOfDrivers'] = this.numOfDrivers;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maleRatio'] = this.maleRatio;
    data['femaleRatio'] = this.femaleRatio;
    return data;
  }
}

class SeasonAnalysisResponse {
  Season? season;

  SeasonAnalysisResponse({this.season});

  SeasonAnalysisResponse.fromJson(Map<String, dynamic> json) {
    season = json['data'] != null ? new Season.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.season != null) {
      data['data'] = this.season!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['summer'] = this.summer;
    data['winter'] = this.winter;
    data['autumn'] = this.autumn;
    data['spring'] = this.spring;
    return data;
  }
}
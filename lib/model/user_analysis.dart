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
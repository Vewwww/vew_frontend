class UserAnalysisResponse {
  int? numOfAllUsers;
  int? numOfMechanists;
  double? numOfWinches;
  double? numOfDrivers;

  UserAnalysisResponse(
      {this.numOfAllUsers,
      this.numOfMechanists,
      this.numOfWinches,
      this.numOfDrivers});

  UserAnalysisResponse.fromJson(Map<String, dynamic> json) {
    numOfAllUsers = json['numOfAllUsers'];
    numOfMechanists = json['numOfMechanists'];
    numOfWinches = json['numOfWinches'];
    numOfDrivers = json['numOfDrivers'];
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
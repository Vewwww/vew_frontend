class ProblemResponse {
  List<ProblemData>? data;

  ProblemResponse({this.data});

  ProblemResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProblemData>[];
      json['data'].forEach((v) {
        data!.add(new ProblemData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProblemData {
  String? sId;
  String? problem;
  String? solution;
  bool? isSolved;
  int? iV;

  ProblemData({this.sId, this.problem, this.solution, this.isSolved, this.iV});

  ProblemData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    problem = json['problem'];
    solution = json['solution'];
    isSolved = json['isSolved'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['problem'] = this.problem;
    data['solution'] = this.solution;
    data['isSolved'] = this.isSolved;
    data['__v'] = this.iV;
    return data;
  }
}

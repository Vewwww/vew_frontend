class ProblemResponse {
  List<ProblemData>? data;

  ProblemResponse({this.data});

  ProblemResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProblemData>[];
      json['data'].forEach((v) {
        data!.add(ProblemData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['problem'] = problem;
    data['solution'] = solution;
    data['isSolved'] = isSolved;
    data['__v'] = iV;
    return data;
  }
}

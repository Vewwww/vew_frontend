class QuestionsResponse {
  int? results;
  List<QuestionsResponseData>? data;

  QuestionsResponse({this.results, this.data});

  QuestionsResponse.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    if (json['data'] != null) {
      data = <QuestionsResponseData>[];
      json['data'].forEach((v) {
        data!.add(new QuestionsResponseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results'] = this.results;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestionsResponseData {
  String? sId;
  String? category;
  List<Questions>? questions;
  int? iV;

  QuestionsResponseData({this.sId, this.category, this.questions, this.iV});

  QuestionsResponseData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    category = json['category'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['category'] = this.category;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class Questions {
  String? subQuestion;
  List<String>? yesKeywords;
  List<String>? noKeywords;
  String? sId;

  Questions({this.subQuestion, this.yesKeywords, this.noKeywords, this.sId});

  Questions.fromJson(Map<String, dynamic> json) {
    subQuestion = json['subQuestion'];
    yesKeywords = json['yesKeywords'].cast<String>();
    noKeywords = json['noKeywords'].cast<String>();
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subQuestion'] = this.subQuestion;
    data['yesKeywords'] = this.yesKeywords;
    data['noKeywords'] = this.noKeywords;
    data['_id'] = this.sId;
    return data;
  }
}

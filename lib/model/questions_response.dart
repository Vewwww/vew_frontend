class QuestionsResponse {
  List<QuestionsResponseData>? data;

  QuestionsResponse({this.data});

  QuestionsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <QuestionsResponseData>[];
      json['data'].forEach((v) {
        data!.add(new QuestionsResponseData.fromJson(v));
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

class QuestionsResponseData {
  String? sId;
  List<Questions>? questions;

  QuestionsResponseData({this.sId, this.questions});

  QuestionsResponseData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
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
    yesKeywords =
        json['yesKeywords'] == null ? [] : json['yesKeywords'].cast<String>();
    noKeywords =
        json['noKeywords'] == null ? [] : json['noKeywords'].cast<String>();
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

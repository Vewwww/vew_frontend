import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/core/style/button_style/app_button_style.dart';
import 'package:vewww/services/dio_helper.dart';

import '../../model/diagnose_result.dart';
import '../../model/problem_response.dart';
import '../../model/questions_response.dart';

part 'diagnose_state.dart';

class DiagnoseCubit extends Cubit<DiagnoseState> {
  DiagnoseCubit() : super(DiagnoseInitial());
  QuestionsResponse? questionsResponse;
  List<String> catigories = [];
  DiagnoseResult? diagnoseResult;
  List<List<String>> keywords = [];
  ProblemResponse? problemResponse;
  static DiagnoseCubit get(context) => BlocProvider.of(context);
  int questionNumber = 0;
  int? selectedAnswer = -1;
  String nextButtonTitle = "Next";
  ButtonStyle previousButtonStyle = disabeledButton;

  void getButtonStyle({isNextButton = true}) {}

  void nextQuestion() {
    if (questionNumber < questionsResponse!.data![0].questions!.length - 1 &&
        selectedAnswer != -1) {
      questionNumber++;
      selectedAnswer = -1;
    }

    previousButtonStyle =
        (questionNumber == 0) ? disabeledButton : enabeledButton;
    print(
        "qyestion number : $questionNumber , cat question length : ${questionsResponse!.data![0].questions!.length}");
    nextButtonTitle =
        (questionNumber == questionsResponse!.data![0].questions!.length - 1)
            ? "Finish"
            : "Next";
    emit(GoNextState());
  }

  void previousQuestion() {
    if (questionNumber > 0) {
      questionNumber--;
      selectedAnswer = -1;
    }
    previousButtonStyle =
        (questionNumber == 0) ? disabeledButton : enabeledButton;

    nextButtonTitle =
        (questionNumber == questionsResponse!.data![0].questions!.length - 1)
            ? "Finish"
            : "Next";

    emit(BackState());
  }

  // Future<void> getAllQuestion() async {
  //   emit(GetAllQuestionLoadingState());
  //   await DioHelper.getData(url: "/question/").then((value) {
  //     print("get all diagnose questions response : ${value.data}");
  //     questionsRrsponse = QuestionsResponse.fromJson(value.data);
  //     emit(GetAllQuestionSuccessState());
  //   }).catchError((err) {
  //     if (err is DioError)
  //       print("get all diagnose questions error : ${err.response}");
  //     print(err);
  //     emit(GetAllQuestionErrorState());
  //   });
  // }

  Future<void> getUnsolvedQuestion() async {
    print("hereeee");
    emit(GetUnsolvedLoadingState());
    await DioHelper.getData(url: "/problem/unsolved").then((value) {
      print("get unsolved questions response : ${value.data}");
      problemResponse = ProblemResponse.fromJson(value.data);
      print("doneee");
      emit(GetUnsolvedSuccessState());
    }).catchError((err) {
      if (err is DioError)
        print("get unsolved questions error : ${err.response}");
      print(err);
      emit(GetUnsolvedErrorState());
    });
  }

  Future<void> getAllCategories() async {
    emit(GetCategoriesLoadingState());
    await DioHelper.getData(url: "/question/getAllCategories").then((value) {
      print("get  all cat response : ${value.data}");
      catigories = value.data['data'].cast<String>();
      print("doneee");
      emit(GetCategoriesSuccessState());
    }).catchError((err) {
      if (err is DioError) print("get Categories error : ${err.response}");
      print(err);
      emit(GetCategoriesErrorState());
    });
  }

  Future<void> getResults() async {
    List<String> caseKeyWords = [];
    for (List<String> k in this.keywords) {
      caseKeyWords.addAll(k);
    }
    print("********************");
    for (String k in caseKeyWords) print(k);
    print("********************");
    print(caseKeyWords.length);
    emit(GetSolutionLoadingState());
    await DioHelper.postData(url: "/case/cbr", data: {"query": caseKeyWords})
        .then((value) {
      print("get all diagnose questions response : ${value.data}");
      diagnoseResult = DiagnoseResult.fromJson(value.data);
      emit(GetSolutionSuccessState());
    }).catchError((err) {
      if (err is DioError)
        print("get all diagnose questions error : ${err.response}");
      print(err);
      emit(GetSolutionErrorState());
    });
  }

  Future<void> addDriverQuestion(String question) async {
    emit(AddQuestionLoadingState());
    await DioHelper.postData(url: "/problem/", data: {
      "problem": question,
    }).then((value) {
      print("add driver problem response : ${value.data}");
      emit(AddQuestionSuccessState());
    }).catchError((err) {
      if (err is DioError) print("add driver problem error : ${err.response}");
      print(err);
      emit(AddQuestionErrorState());
    });
  }

  Future<void> getQuestionsByCategory(String cat) async {
    emit(GetQuestionsLoadingState());
    await DioHelper.getData(url: "/question/category/$cat").then((value) {
      print("get cat questions response : ${value.data}");
      questionsResponse = QuestionsResponse.fromJson(value.data);
      print("doneee:\n${questionsResponse!.toJson()}");
      emit(GetQuestionsSuccessState());
    }).catchError((err) {
      if (err is DioError)
        print("get Category  questions error : ${err.response}");
      print(err);
      emit(GetQuestionsErrorState());
    });
  }

  void chooseAnswer(int? val, List<String> keywords) {
    selectedAnswer = val;
    print("${this.keywords.length - 1} , ${questionNumber}");
    if (selectedAnswer == 0) {
      if (this.keywords.length - 1 > questionNumber) {
        print("replace");
        this.keywords.removeAt(questionNumber);
        this.keywords.insert(questionNumber, keywords);
      } else if (this.keywords.length == questionNumber) {
        print("add");
        this.keywords.add(keywords);
      }
      print("keywords added");
    } else {
      if (this.keywords.length - 1 > questionNumber)
        this.keywords.removeAt(questionNumber);
      else
        this.keywords.add([]);
      print("keywords removed");
    }
    emit(AnswerChoosedState());
  }

  Future<void> solveDriverQuestion(
      ProblemData problemData, String solution) async {
    problemData.solution = solution;
    problemData.isSolved = true;
    print("solve problem request: ${problemData.toJson()}");
    emit(SolveQuestionLoadingState());
    await DioHelper.putData(
            url: "/problem/${problemData.sId}", data: problemData.toJson())
        .then((value) {
      print("solve driver problem response : ${value.data}");
      emit(SolveQuestionSuccessState());
    }).catchError((err) {
      if (err is DioError)
        print("solve driver problem error : ${err.response}");
      print(err);
      emit(SolveQuestionErrorState());
    });
  }
}

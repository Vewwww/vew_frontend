import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/core/style/button_style/app_button_style.dart';
import 'package:vewww/services/dio_helper.dart';
import '../../core/utils/sp_helper/cache_helper.dart';
import '../../model/case.dart';
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

  //get next question for user diagnose when press next
  void nextQuestion() {
    if (questionNumber < questionsResponse!.data![0].questions!.length - 1 &&
        selectedAnswer != -1) {
      questionNumber++;
      selectedAnswer = -1;
    }
    previousButtonStyle =
        (questionNumber == 0) ? disabeledButton : enabeledButton;
    nextButtonTitle =
        (questionNumber == questionsResponse!.data![0].questions!.length - 1)
            ? "Finish"
            : "Next";
    emit(GoNextState());
  }

  //get previous question for user diagnose when press back
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

  //get unsolved quesion to mechanic to provide solutions
  Future<void> getUnsolvedQuestion() async {
    emit(GetUnsolvedLoadingState());
    await DioHelper.getData(url: "/problem/unsolved").then((value) {
      problemResponse = ProblemResponse.fromJson(value.data);
      emit(GetUnsolvedSuccessState());
    }).catchError((err) {
      emit(GetUnsolvedErrorState());
    });
  }

  //get all diagnose categories 
  Future<void> getAllCategories() async {
    emit(GetCategoriesLoadingState());
    await DioHelper.getData(url: "/question/getAllCategories").then((value) {
      catigories = value.data['data'].cast<String>();
      emit(GetCategoriesSuccessState());
    }).catchError((err) {
      emit(GetCategoriesErrorState());
    });
  }

  //get cbr result based on the key words selected
  Future<void> getResults() async {
    List<String> caseKeyWords = [];
    for (List<String> k in keywords) {
      caseKeyWords.addAll(k);
    }
    emit(GetSolutionLoadingState());
    await DioHelper.postData(url: "/case/cbr", data: {"query": caseKeyWords})
        .then((value) {
      diagnoseResult = DiagnoseResult.fromJson(value.data);
      emit(GetSolutionSuccessState());
    }).catchError((err) {
      emit(GetSolutionErrorState());
    });
  }

  //add driver question to unsolved questions to display it 
  //to mechnic so they car provide answers and feed the database   
  Future<void> addDriverQuestion(String question) async {
    emit(AddQuestionLoadingState());
    await DioHelper.postData(url: "/problem/", data: {
      "problem": question,
    }).then((value) {
      emit(AddQuestionSuccessState());
    }).catchError((err) {
      emit(AddQuestionErrorState());
    });
  }

  //get question of specific category
  Future<void> getQuestionsByCategory(String cat) async {
    emit(GetQuestionsLoadingState());
    await DioHelper.getData(url: "/question/category/$cat").then((value) {
      questionsResponse = QuestionsResponse.fromJson(value.data);
      emit(GetQuestionsSuccessState());
    }).catchError((err) {
      emit(GetQuestionsErrorState());
    });
  }

  // add keywords of user answer to specific 
  //question to the total keywords of the case
  void chooseAnswer(int? val, List<String> keywords) {
    selectedAnswer = val;
    if (this.keywords.length - 1 > questionNumber) {
      this.keywords.removeAt(questionNumber);
      this.keywords.insert(questionNumber, keywords);
    } else if (this.keywords.length == questionNumber) {
      this.keywords.add(keywords);
    }
    emit(AnswerChoosedState());
  }

  //answer provided by mechanic for unsolved questions
  Future<void> solveDriverQuestion(
      ProblemData problemData, String solution) async {
    problemData.solution = solution;
    problemData.isSolved = true;
    emit(SolveQuestionLoadingState());
    await DioHelper.putData(
            url: "/problem/${problemData.sId}", data: problemData.toJson())
        .then((value) {
      emit(SolveQuestionSuccessState());
    }).catchError((err) {
      emit(SolveQuestionErrorState());
    });
  }

  void addCase(Case aCase) async {
    emit(AddCaseLoadingState());
    await DioHelper.postData(
      url: "/case/",
      data: aCase.toJson(),
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      emit(AddCaseSuccessState());
    }).catchError((error) {
      emit(AddCaseErrorState());
    });
  }
}

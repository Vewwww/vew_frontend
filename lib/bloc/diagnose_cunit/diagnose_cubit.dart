import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/core/style/button_style/app_button_style.dart';
import 'package:vewww/model/diagnose_question.dart';

part 'diagnose_state.dart';

class DiagnoseCubit extends Cubit<DiagnoseState> {
  DiagnoseCubit() : super(DiagnoseInitial());
  static DiagnoseCubit get(context) => BlocProvider.of(context);
  int questionNumber = 0;
  int? selectedAnswer = -1;
  String nextButtonTitle = "Next";
  ButtonStyle previousButtonStyle = disabeledButton;

  void getButtonStyle({isNextButton = true}) {}

  void nextQuestion() {
    if (questionNumber < questions.length - 1 && selectedAnswer != -1) {
      questionNumber++;
      selectedAnswer = -1;
    }

    previousButtonStyle =
        (questionNumber == 0) ? disabeledButton : enabeledButton;

    nextButtonTitle =
        (questionNumber == questions.length - 1) ? "Finish" : "Next";
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
        (questionNumber == questions.length - 1) ? "Finish" : "Next";

    emit(BackState());
  }

  void chooseAnswer(int? val) {
    selectedAnswer = val;
    emit(AnswerChoosedState());
  }
}

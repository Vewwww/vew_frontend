part of 'diagnose_cubit.dart';

@immutable
abstract class DiagnoseState {}

class DiagnoseInitial extends DiagnoseState {}

class GoNextState extends DiagnoseState {}

class BackState extends DiagnoseState {}

class AnswerChoosedState extends DiagnoseState {}

class GetAllQuestionLoadingState extends DiagnoseState {}

class GetAllQuestionSuccessState extends DiagnoseState {}

class GetAllQuestionErrorState extends DiagnoseState {}

class GetUnsolvedLoadingState extends DiagnoseState {}

class GetUnsolvedSuccessState extends DiagnoseState {}

class GetUnsolvedErrorState extends DiagnoseState {}

class GetSolutionLoadingState extends DiagnoseState {}

class GetSolutionSuccessState extends DiagnoseState {}

class GetSolutionErrorState extends DiagnoseState {}

class GetCategoriesLoadingState extends DiagnoseState {}

class GetCategoriesSuccessState extends DiagnoseState {}

class GetCategoriesErrorState extends DiagnoseState {}

class GetQuestionsLoadingState extends DiagnoseState {}

class GetQuestionsSuccessState extends DiagnoseState {}

class GetQuestionsErrorState extends DiagnoseState {}

class AddQuestionLoadingState extends DiagnoseState {}

class AddQuestionSuccessState extends DiagnoseState {}

class AddQuestionErrorState extends DiagnoseState {}

class SolveQuestionLoadingState extends DiagnoseState {}

class SolveQuestionSuccessState extends DiagnoseState {}

class SolveQuestionErrorState extends DiagnoseState {}

class AddCaseLoadingState extends DiagnoseState {}

class AddCaseSuccessState extends DiagnoseState {}

class AddCaseErrorState extends DiagnoseState {}

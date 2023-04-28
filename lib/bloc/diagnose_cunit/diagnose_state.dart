part of 'diagnose_cubit.dart';

@immutable
abstract class DiagnoseState {}

class DiagnoseInitial extends DiagnoseState {}

class GoNextState extends DiagnoseState {}

class BackState extends DiagnoseState {}

class AnswerChoosedState extends DiagnoseState {}

part of 'warning_sign_cubit.dart';

@immutable
abstract class WarningSignState {}

class WarningSignInitial extends WarningSignState {}

class GetAllWarningSignLoadingState extends WarningSignState {}

class GetAllWarningSignSuccessState extends WarningSignState {
final List<Sign> signs;
GetAllWarningSignSuccessState({required this.signs});
}

class GetAllWarningSignErrorState extends WarningSignState {}

class GetSingleWarningSignLoadingState extends WarningSignState {}

class GetSingleWarningSignSuccessState extends WarningSignState {
  final Sign sign;
  GetSingleWarningSignSuccessState({required this.sign});
}

class GetSingleWarningSignErrorState extends WarningSignState {}

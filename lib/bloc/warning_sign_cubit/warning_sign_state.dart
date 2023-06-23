part of 'warning_sign_cubit.dart';

@immutable
abstract class WarningSignState {}

class WarningSignInitial extends WarningSignState {}
class GetAllWarningSignLoadingState extends WarningSignState {}
class GetAllWarningSignSuccessState extends WarningSignState {}
class GetAllWarningSignErrorState extends WarningSignState {}


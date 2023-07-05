part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class SignInLoadingState extends AuthState {}

class SignInSuccessState extends AuthState {}

class SignInErrorState extends AuthState {
  final errMessage;
  SignInErrorState({required this.errMessage});
}

class LogoutLoadingState extends AuthState {}

class LogoutSuccessState extends AuthState {}

class LogoutErrorState extends AuthState {}

class SignUpLoadingState extends AuthState {}

class SignUpSuccessState extends AuthState {
  String? message;
  SignUpSuccessState({this.message});
}

class SignUpErrorState extends AuthState {
  final errMessage;
  SignUpErrorState({required this.errMessage});
}

class SendingCodeLoadingState extends AuthState {}

class SendingCodeSuccessState extends AuthState {}

class SendingCodeErrorState extends AuthState {
  final String errMessage;
  SendingCodeErrorState({required this.errMessage});
}

class ResetPasswordLoadingState extends AuthState {}

class ResetPasswordSuccessState extends AuthState {}

class ResetPasswordErrorState extends AuthState {
  final errMessage;
  ResetPasswordErrorState({required this.errMessage});
}

class ChangePasswordLoadingState extends AuthState {}

class ChangePasswordSuccessState extends AuthState {}

class ChangePasswordErrorState extends AuthState {
  final errMessage;
  ChangePasswordErrorState({required this.errMessage});
}

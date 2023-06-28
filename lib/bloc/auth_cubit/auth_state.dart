part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class SignInLoadingState extends AuthState {}

class SignInSuccessState extends AuthState {}

class SignInErrorState extends AuthState {}

class LogoutLoadingState extends AuthState {}

class LogoutSuccessState extends AuthState {}

class LogoutErrorState extends AuthState {}

class SignUpLoadingState extends AuthState {}

class SignUpSuccessState extends AuthState {}

class SignUpErrorState extends AuthState {}

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

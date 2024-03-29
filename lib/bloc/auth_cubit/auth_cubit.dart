import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/core/utils/sp_helper/cache_helper.dart';
import 'package:vewww/model/error_response.dart';
import 'package:vewww/services/dio_helper.dart';
import '../../model/driver.dart';
import '../../model/mechanic_shop.dart';
import '../../model/person.dart';
import '../../model/winch_driver.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);
  Driver driver = Driver();

  Future<void> driverSignUp(Driver driver) async {
    emit(SignUpLoadingState());
    await DioHelper.postData(url: "driver/signup/", data: driver.toSignupJson())
        .then((value) {
      emit(SignUpSuccessState());
    }).catchError((err) {
      if (err is DioError) {
        if ((err.response != null)) {
          ErrorResponse errorResponse =
              ErrorResponse.fromJson(err.response!.data);
          emit(SignUpErrorState(
              errMessage: (errorResponse.message != null)
                  ? errorResponse.message!
                  : "Something went wrong, try again"));
        } else {
          emit(SignUpErrorState(errMessage: "Something went wrong, try again"));
        }
      }
    });
  }

  Future<void> winchSignUp(WinchDriver winch) async {
    emit(SignUpLoadingState());
    await DioHelper.postData(url: "winch/signup/", data: winch.toJson())
        .then((value) {
      emit(SignUpSuccessState());
    }).catchError((err) {
      if (err is DioError) {
        if ((err.response != null)) {
          ErrorResponse errorResponse =
              ErrorResponse.fromJson(err.response!.data);
          emit(SignUpErrorState(
              errMessage: (errorResponse.message != null)
                  ? errorResponse.message!
                  : "Something went wrong, try again"));
        } else {
          emit(SignUpErrorState(errMessage: "Something went wrong, try again"));
        }
      }
    });
  }

  Future<void> mechanicSignUp(MechanicShop mechanicShop) async {
    emit(SignUpLoadingState());
    await DioHelper.postData(
            url: "/mechanic/signup/", data: mechanicShop.toSignupJson())
        .then((value) {
      emit(SignUpSuccessState(message: value.data['message']));
    }).catchError((err) {
      if (err is DioError) {
        if ((err.response != null)) {
          ErrorResponse errorResponse =
              ErrorResponse.fromJson(err.response!.data);
          emit(SignUpErrorState(
              errMessage: (errorResponse.message != null)
                  ? errorResponse.message!
                  : "Something went wrong, try again"));
        } else {
          emit(SignUpErrorState(errMessage: "Something went wrong, try again"));
        }
      }
    });
  }

  Future<void> signIn(Person person) async {
    emit(SignInLoadingState());
    await DioHelper.postData(
            url: "/allusers/login/",
            data: {"email": person.email, "password": person.password})
        .then((value) {
      Person person = SignInResponse.fromJson(value.data).person!;
      SharedPreferencesHelper.saveData(key: 'vewToken', value: person.token);
      SharedPreferencesHelper.saveData(key: 'vewRole', value: person.role);
      SharedPreferencesHelper.saveData(key: 'vewId', value: person.sId);

      emit(SignInSuccessState());
    }).catchError((err) {
      if (err is DioError) {
        if ((err.response != null)) {
          ErrorResponse errorResponse =
              ErrorResponse.fromJson(err.response!.data);
          emit(SignInErrorState(
              errMessage: (errorResponse.message != null)
                  ? errorResponse.message!
                  : "Something went wrong, try again"));
        } else {
          emit(SignInErrorState(errMessage: "Something went wrong, try again"));
        }
      }
    });
  }

  Future<void> logout() async {
    emit(LogoutLoadingState());
    await DioHelper.getData(
      url: "/allusers/logout/",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      SharedPreferencesHelper.removeData(key: 'vewToken');
      SharedPreferencesHelper.removeData(key: 'vewRole');
      emit(LogoutSuccessState());
    }).onError((error, stackTrace) {
      emit(LogoutErrorState());
    });
  }

  // verification code from email to reset password
  Future sendResetPasswordCode(String email) async {
    emit(SendingCodeLoadingState());
    await DioHelper.postData(
        url: "/allusers/forgetPassword/", data: {"email": email}).then((value) {
      emit(SendingCodeSuccessState());
    }).catchError((err) {
      if (err is DioError) {
        if ((err.response != null)) {
          ErrorResponse errorResponse =
              ErrorResponse.fromJson(err.response!.data);
          emit(SendingCodeErrorState(
              errMessage: (errorResponse.message != null)
                  ? errorResponse.message!
                  : "Something went wrong, try again"));
        } else {
          emit(SendingCodeErrorState(
              errMessage: "Something went wrong, try again"));
        }
      }
    });
  }

  //Forget password
  Future resetPassword(String email, String newPassword) async {
    emit(ResetPasswordLoadingState());
    await DioHelper.postData(
        url: "/allusers/resetPassword/",
        data: {"email": email, "password": newPassword}).then((value) {
      emit(ResetPasswordSuccessState());
    }).catchError((err) {
      if (err is DioError) {
        if ((err.response != null)) {
          ErrorResponse errorResponse =
              ErrorResponse.fromJson(err.response!.data);
          emit(ResetPasswordErrorState(
              errMessage: (errorResponse.message != null)
                  ? errorResponse.message!
                  : "Something went wrong, try again"));
        } else {
          emit(ResetPasswordErrorState(
              errMessage: "Something went wrong, try again"));
        }
      }
    });
  }

  Future changePassword(String newPassword) async {
    emit(ChangePasswordLoadingState());
    await DioHelper.patchData(
        url: "/driver/changePassword/",
        token: SharedPreferencesHelper.getData(key: 'vewToken'),
        data: {"password": newPassword}).then((value) {
      emit(ChangePasswordSuccessState());
    }).catchError((err) {
      if (err is DioError) {
        if ((err.response != null)) {
          ErrorResponse errorResponse =
              ErrorResponse.fromJson(err.response!.data);
          emit(ChangePasswordErrorState(
              errMessage: (errorResponse.message != null)
                  ? errorResponse.message!
                  : "Something went wrong, try again"));
        } else {
          emit(ChangePasswordErrorState(
              errMessage: "Something went wrong, try again"));
        }
      }
    });
  }
}

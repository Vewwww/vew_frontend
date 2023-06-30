import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:vewww/core/utils/sp_helper/cache_helper.dart';
import 'package:vewww/model/error_response.dart';
import 'package:vewww/services/dio_helper.dart';

import '../../model/driver.dart';
import '../../model/mechanic_shop.dart';
import '../../model/person.dart';
import '../../model/repairer.dart';
import '../../model/winch.dart';
import '../../model/winch_driver.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  void driverSignUp(Driver driver) async {
    print("driver signup request : ${driver.toJson()}");
    emit(SignUpLoadingState());
    await DioHelper.postData(url: "driver/signup/", data: driver.toJson())
        .then((value) {
      print("driver signup response : ${value}");
      emit(SignUpSuccessState());
    }).catchError((err) {
      if (err is DioError) {
        print("driver signup error message : ${err.response!.data}");
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
    print("winch signup request : ${driver.toJson()}");
    emit(SignUpLoadingState());
    print("winch signup request = ${winch.toJson()}");
    await DioHelper.postData(url: "winch/signup/", data: winch.toJson())
        .then((value) {
      print("winch signup response : ${value}");
      emit(SignUpSuccessState());
    }).catchError((err) {
      if (err is DioError) {
        print("winch signup error message : ${err.response!.data}");
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
    print("mechanic signup request : ${driver.toJson()}");
    emit(SignUpLoadingState());
    print("mechanic signup request = ${mechanicShop.toJson()}");
    await DioHelper.postData(
            url: "/mechanic/signup/", data: mechanicShop.toJson())
        .then((value) {
      print("mechanic signup response : ${value}");
      emit(SignUpSuccessState(message: value.data['message']));
    }).catchError((err) {
      if (err is DioError) {
        print("winch signup error message : ${err.response!.data}");
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
    print("driver signin request : ${driver.toJson()}");
    emit(SignInLoadingState());
    await DioHelper.postData(
            url: "/allusers/login/",
            data: {"email": person.email, "password": person.password})
        .then((value) {
      print("sign in response : ${value.data}");
      Person person = SignInResponse.fromJson(value.data).person!;
      print("person = ${person.token} , ${person.role}");
      SharedPreferencesHelper.saveData(key: 'vewToken', value: person.token);
      SharedPreferencesHelper.saveData(key: 'vewRole', value: person.role);
      SharedPreferencesHelper.saveData(key: 'vewId', value: person.sId);
      emit(SignInSuccessState());
    }).catchError((err) {
      if (err is DioError) {
        print("sign in error message : ${err.response!.data}");
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
    print("driver logout request : ${driver.toJson()}");
    emit(LogoutLoadingState());
    await DioHelper.getData(
      url: "/allusers/logout/",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      print("logout response : ${value.data}");
      SharedPreferencesHelper.removeData(key: 'vewToken');
      SharedPreferencesHelper.removeData(key: 'vewRole');
      emit(LogoutSuccessState());
    }).onError((error, stackTrace) {
      print("error in driver sign in : $error");
      emit(LogoutErrorState());
    });
  }

  Future sendResetPasswordCode(String email) async {
    emit(SendingCodeLoadingState());
    await DioHelper.postData(
        url: "/allusers/forgetPassword/", data: {"email": email}).then((value) {
      print("sending reset password code response: ${value.data}");
      emit(SendingCodeSuccessState());
    }).catchError((err) {
      if (err is DioError) {
        print(
            "sending reset password code  error message : ${err.response!.data}");
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

  Future resetPassword(String email, String newPassword) async {
    emit(ResetPasswordLoadingState());
    await DioHelper.postData(
        url: "/allusers/resetPassword/",
        data: {"email": email, "password": newPassword}).then((value) {
      print(" reset password  response: ${value.data}");
      emit(ResetPasswordSuccessState());
    }).catchError((err) {
      if (err is DioError) {
        print("reset password  error message : ${err.response!.data} ");
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
      print(" change password  response: ${value.data}");
      emit(ChangePasswordSuccessState());
    }).catchError((err) {
      if (err is DioError) {
        print("change password  error message : ${err.response!.data} ");
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

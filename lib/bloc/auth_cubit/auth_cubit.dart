import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:vewww/services/dio_helper.dart';

import '../../model/driver.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  void driverSignUp(Driver driver) {
    print("driver signup request : ${driver.toJson()}");
    DioHelper.postData(url: "driver/signup/", data: driver.toJson())
        .then((value) {
      print("driver signup response : ${value}");
    }).onError((error, stackTrace) {
      print("error in driver sign up : $error");
    });
  }

  void signIn(Driver driver) {
    print("driver signin request : ${driver.toJson()}");
    DioHelper.postData(
            url: "allusers/login/",
            data: {"email": driver.email, "password": driver.password})
        .then((value) {
      print("driver sign in response : ${value.data}");
    }).onError((error, stackTrace) {
      print("error in driver sign in : $error");
    });
  }
}

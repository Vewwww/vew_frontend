import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:vewww/core/utils/sp_helper/cache_helper.dart';
import 'package:vewww/services/dio_helper.dart';

import '../../model/driver.dart';
import '../../model/person.dart';

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
    }).onError((error, stackTrace) {
      print("error in driver sign up : $error");
      emit(SignUpErrorState());
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
      emit(SignInSuccessState());
    }).onError((error, stackTrace) {
      print("error in driver sign in : $error");
      emit(SignInErrorState());
    });
  }
  Future<void> logout() async {
    print("driver logout request : ${driver.toJson()}");
    emit(LogoutLoadingState());
    await DioHelper.getData(
            url: "/allusers/logout/",
            token: SharedPreferencesHelper.getData(key: 'vewToken'),
            )
        .then((value) {
      print("logout response : ${value.data}");
      SharedPreferencesHelper.removeData(key: 'vewToken');
      SharedPreferencesHelper.removeData(key: 'vewRole');
      emit(LogoutSuccessState());
    }).onError((error, stackTrace) {
      print("error in driver sign in : $error");
      emit(LogoutErrorState());
    });
  }
}

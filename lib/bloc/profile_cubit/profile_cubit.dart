import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:vewww/services/dio_helper.dart';

import '../../core/utils/sp_helper/cache_helper.dart';
import '../../model/admin.dart';
import '../../model/profile_response.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  static ProfileCubit get(context) => BlocProvider.of(context);
  ProfileResponse? profileResponse;
  AdminProfileResponse? adminProfileResponse;
  ProfileCubit() : super(ProfileInitial());
  Future<void> getDriverProfile() async {
    emit(GettingProfileLoadingState());
    await DioHelper.getData(
            url: "/driver/getProfile",
            token: SharedPreferencesHelper.getData(key: 'vewToken'))
        .then((value) {
      print("get driver profile response : ${value.data}");
      profileResponse = ProfileResponse.fromJson(value.data);
      emit(GettingProfileSuccessState());
    }).catchError((err) {
      if (err is DioError) {
        print(err.response);
      }
      emit(GettingProfileErrorState());
    });
  }

  Future<void> getAdminProfile() async {
    emit(GettingProfileLoadingState());
    await DioHelper.getData(
            url: "/admin/getProfile",
            token: SharedPreferencesHelper.getData(key: 'vewToken'))
        .then((value) {
      print("get admin profile response : ${value.data}");
      adminProfileResponse = AdminProfileResponse.fromJson(value.data);
      emit(GettingProfileSuccessState());
    }).catchError((err) {
      if (err is DioError) {
        print(err.response);
      }
      print("error");
      emit(GettingProfileErrorState());
    });
  }
}

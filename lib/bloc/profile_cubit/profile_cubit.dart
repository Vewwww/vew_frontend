import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/model/mechanic_shop.dart';
import 'package:vewww/services/dio_helper.dart';

import '../../core/utils/sp_helper/cache_helper.dart';
import '../../model/admin.dart';
import '../../model/profile_response.dart';
import '../../model/winch_driver.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  static ProfileCubit get(context) => BlocProvider.of(context);
  ProfileResponse? profileResponse;
  AdminProfileResponse? adminProfileResponse;
  MechanicProfileResponse? mechanicProfileResponse;
  WinchProfileResponse? winchDriverResponse;
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
      print(err);

      emit(GettingProfileErrorState());
    });
  }

  Future<void> EditDriverProfile(Map<String, dynamic> driver) async {
    emit(EdittingProfileLoadingState());
    await DioHelper.putData(
            url: "/driver/",
            data: driver,
            token: SharedPreferencesHelper.getData(key: 'vewToken'))
        .then((value) {
      print("edit driver profile response : ${value.data}");
      //profileResponse = ProfileResponse.fromJson(value.data);
      emit(EdittingProfileSuccessState());
    }).catchError((err) {
      if (err is DioError) {
        print(err.response);
      }
      print(err);

      emit(EdittingProfileErrorState());
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

  Future<void> getMechanicProfile() async {
    emit(GettingProfileLoadingState());
    await DioHelper.getData(
            url: "/mechanic/getMechanicProfile",
            token: SharedPreferencesHelper.getData(key: 'vewToken'))
        .then((value) {
      print("get mechanic profile response : ${value.data}");
      mechanicProfileResponse = MechanicProfileResponse.fromJson(value.data);
      emit(GettingProfileSuccessState());
    }).catchError((err) {
      if (err is DioError) {
        print(err.response);
      }
      print("error");
      emit(GettingProfileErrorState());
    });
  }

  Future<void> getWinchProfile() async {
    emit(GettingProfileLoadingState());
    await DioHelper.getData(
            url: "/winch/getWinchProfile",
            token: SharedPreferencesHelper.getData(key: 'vewToken'))
        .then((value) {
      print("get winch profile response : ${value.data}");
      winchDriverResponse = WinchProfileResponse.fromJson(value.data);
      emit(GettingProfileSuccessState());
    }).catchError((err) {
      if (err is DioError) {
        print(err.response);
      }
      print("error");
      emit(GettingProfileErrorState());
    });
  }

  Future<void> updateWinchProfile(WinchDriver winchDriver) async {
    emit(EdittingProfileLoadingState());
    await DioHelper.patchData(
            url: "/winch/updateWinchProfile",
            data: winchDriver.toJson(),
            token: SharedPreferencesHelper.getData(key: 'vewToken'))
        .then((value) {
      print("edit winch profile response : ${value.data}");
      winchDriverResponse = WinchProfileResponse.fromJson(value.data);
      emit(EdittingProfileSuccessState());
    }).catchError((err) {
      if (err is DioError) {
        print(err.response);
      }
      print("error");
      emit(EdittingProfileErrorState());
    });
  }

  Future<void> updateMechanicProfile(MechanicShop mechanicShop) async {
    emit(EdittingProfileLoadingState());
    await DioHelper.patchData(
            url: "/mechanic/updateMechanicProfile",
            data: mechanicShop.toJson(),
            token: SharedPreferencesHelper.getData(key: 'vewToken'))
        .then((value) {
      print("edit mechanic profile response : ${value.data}");
      emit(EdittingProfileSuccessState());
    }).catchError((err) {
      if (err is DioError) {
        print(err.response);
      }
      print("error");
      emit(EdittingProfileErrorState());
    });
  }
}

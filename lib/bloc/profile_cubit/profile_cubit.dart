import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/model/mechanic_shop.dart';
import 'package:vewww/services/dio_helper.dart';
import '../../core/utils/sp_helper/cache_helper.dart';
import '../../model/admin.dart';
import '../../model/car.dart';
import '../../model/error_response.dart';
import '../../model/profile_response.dart';
import '../../model/winch_driver.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  static ProfileCubit get(context) => BlocProvider.of(context);
  ProfileResponse? profileResponse;
  AdminProfileResponse? adminProfileResponse;
  MechanicProfileResponse? mechanicProfileResponse;
  WinchProfileResponse? winchDriverResponse;
  bool isWinchAvailable = false;
  ProfileCubit() : super(ProfileInitial());

  Future<void> getDriverProfile() async {
    emit(GettingProfileLoadingState());
    await DioHelper.getData(
            url: "/driver/getProfile",
            token: SharedPreferencesHelper.getData(key: 'vewToken'))
        .then((value) {
      profileResponse = ProfileResponse.fromJson(value.data);
      if (profileResponse != null &&
          profileResponse!.data != null &&
          profileResponse!.data!.cars != null) {
        for (Car c in profileResponse!.data!.cars!) {
          c.owner = profileResponse!.data!.user!.sId!;
        }
      }
      emit(GettingProfileSuccessState());
    }).catchError((err) {
      emit(GettingProfileErrorState());
    });
  }

  Future<void> editDriverProfile(Map<String, dynamic> driver) async {
    emit(EdittingProfileLoadingState());
    await DioHelper.putData(
            url: "/driver/",
            data: driver,
            token: SharedPreferencesHelper.getData(key: 'vewToken'))
        .then((value) {
      emit(EdittingProfileSuccessState());
    }).catchError((err) {
      if (err is DioError) {
        if (err.response != null) {
          ErrorResponse errorResponse =
              ErrorResponse.fromJson(err.response!.data);
          emit(EdittingProfileErrorState((errorResponse.message != null)
              ? errorResponse.message!
              : "Something went wrong, try again"));
        }
      }

      emit(EdittingProfileErrorState("Something went wrong, try again"));
    });
  }

  Future<void> updateWinchState(bool isAvailable) async {
    emit(WinchAvailabityLoadingState());
    await DioHelper.patchData(
        url: "/winch/updateAvailableState",
        token: SharedPreferencesHelper.getData(key: 'vewToken'),
        data: {"available": isAvailable}).then((value) {
      isWinchAvailable = isAvailable;
      emit(WinchAvailabitySuccessState());
    }).onError((error, stackTrace) {
      emit(WinchAvailabityErrorState());
    });
  }

  Future<void> getAdminProfile() async {
    emit(GettingProfileLoadingState());
    await DioHelper.getData(
            url: "/admin/getProfile",
            token: SharedPreferencesHelper.getData(key: 'vewToken'))
        .then((value) {
      adminProfileResponse = AdminProfileResponse.fromJson(value.data);
      emit(GettingProfileSuccessState());
    }).catchError((err) {
      if (err is DioError) {}
      emit(GettingProfileErrorState());
    });
  }

  Future<void> updateAdminProfile(Admin admin) async {
    emit(EdittingProfileLoadingState());
    await DioHelper.patchData(
            url: "/admin/updateProfile",
            data: admin.toUpdateJson(),
            token: SharedPreferencesHelper.getData(key: 'vewToken'))
        .then((value) {
      adminProfileResponse = AdminProfileResponse.fromJson(value.data);
      emit(EdittingProfileSuccessState());
    }).catchError((err) {
      if (err is DioError) {
        if (err.response != null) {
          ErrorResponse errorResponse =
              ErrorResponse.fromJson(err.response!.data);
          emit(EdittingProfileErrorState((errorResponse.message != null)
              ? errorResponse.message!
              : "Something went wrong, try again"));
        }
      }

      emit(EdittingProfileErrorState("Something went wrong, try again"));
    });
  }

  Future<void> getMechanicProfile() async {
    emit(GettingProfileLoadingState());
    await DioHelper.getData(
            url: "/mechanic/getMechanicProfile",
            token: SharedPreferencesHelper.getData(key: 'vewToken'))
        .then((value) {
      mechanicProfileResponse = MechanicProfileResponse.fromJson(value.data);
      emit(GettingProfileSuccessState());
    }).catchError((err) {
      if (err is DioError) {}
      emit(GettingProfileErrorState());
    });
  }

  Future<void> getWinchProfile() async {
    emit(GettingProfileLoadingState());
    await DioHelper.getData(
            url: "/winch/getWinchProfile",
            token: SharedPreferencesHelper.getData(key: 'vewToken'))
        .then((value) {
      winchDriverResponse = WinchProfileResponse.fromJson(value.data);
      isWinchAvailable = winchDriverResponse!.winch!.available ?? false;
      emit(GettingProfileSuccessState());
    }).catchError((err) {
      if (err is DioError) {}
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
      winchDriverResponse = WinchProfileResponse.fromJson(value.data);
      emit(EdittingProfileSuccessState());
    }).catchError((err) {
      if (err is DioError) {
        if (err.response != null) {
          ErrorResponse errorResponse =
              ErrorResponse.fromJson(err.response!.data);
          emit(EdittingProfileErrorState((errorResponse.message != null)
              ? errorResponse.message!
              : "Something went wrong, try again"));
        }
      }

      emit(EdittingProfileErrorState("Something went wrong, try again"));
    });
  }

  Future<void> updateMechanicProfile(MechanicShop mechanicShop) async {
    emit(EdittingProfileLoadingState());
    await DioHelper.patchData(
            url: "/mechanic/updateMechanicProfile",
            data: mechanicShop.toJson(),
            token: SharedPreferencesHelper.getData(key: 'vewToken'))
        .then((value) {
      emit(EdittingProfileSuccessState());
    }).catchError((err) {
      if (err is DioError) {
        if (err.response != null) {
          ErrorResponse errorResponse =
              ErrorResponse.fromJson(err.response!.data);
          emit(EdittingProfileErrorState((errorResponse.message != null)
              ? errorResponse.message!
              : "Something went wrong, try again"));
        }
      }

      emit(EdittingProfileErrorState("Something went wrong, try again"));
    });
  }
}

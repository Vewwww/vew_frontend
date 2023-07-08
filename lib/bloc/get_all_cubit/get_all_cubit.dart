import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/model/nearest_gas_station_response.dart';
import 'package:vewww/model/repairer.dart';
import '../../core/utils/sp_helper/cache_helper.dart';
import '../../model/admin.dart';
import '../../model/driver.dart';
import '../../model/mechanic_shop.dart';
import '../../model/nearest_MC_response.dart';
import '../../model/winch_driver.dart';
import '../../services/dio_helper.dart';
part 'get_all_state.dart';

class GetAllCubit extends Cubit<GetAllState> {
  GetAllCubit() : super(GetAllInitial());
  static GetAllCubit get(context) => BlocProvider.of(context);
  MechnaicShopResponse? mechnaicShopResponse;
  WinchDriver? winchDriver;
  Driver? driver;
  MechanicShop? mechanicShop;
  NearesetGasStationResponse? nearesetGasStationResponse;
  NearesetMCResponse? nearesetMCResponse;

  Future getAllMechanicShop() async {
    String url = "/admin/mechanic/";
    emit(GetAllMechanicShopLoadingState());
    await DioHelper.getData(
      url: url,
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      mechnaicShopResponse = MechnaicShopResponse.fromJson(value.data);
      emit(GetAllMechanicShopSuccessState(mechnaicShopResponse!.mechanicShop!));
    }).onError((error, stackTrace) {
      emit(GetAllMechanicShopErrorState());
    });
  }

  Future getAllWinchDrivers() async {
    String url = "/admin/winch/";
    emit(GetAllWinchDriversLoadingState());
    await DioHelper.getData(
      url: url,
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      WinchDriverResponse winchDriverResponse =
          WinchDriverResponse.fromJson(value.data);
      emit(GetAllWinchDriversSuccessState(winchDriverResponse.winchDriver!));
    }).onError((error, stackTrace) {
      emit(GetAllWinchDriversErrorState());
    });
  }

  Future getAllDrivers() async {
    String url = "/admin/driver/";
    emit(GetAllDriversLoadingState());
    await DioHelper.getData(
      url: url,
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      DriverResponse driverResponse = DriverResponse.fromJson(value.data);
      emit(GetAllDriversSuccessState(driverResponse.driver!));
    }).onError((error, stackTrace) {
      emit(GetAllDriversErrorState());
    });
  }

  Future getAllAdmin() async {
    String url = "/admin/admins/";
    emit(GetAllAdminsLoadingState());
    await DioHelper.getData(
      url: url,
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      AdminResponse adminRespone = AdminResponse.fromJson(value.data);
      emit(GetAllAdminsSuccessState(adminRespone.admins!));
    }).catchError((error) {
      if (error is DioError) {}
      emit(GetAllAdminsErrorState());
    });
  }

  Future getAllGasStation() async {
    String url = "/admin/gasStation/";
    emit(GetAllGasStationLoadingState());
    if (nearesetGasStationResponse == null) {
      await DioHelper.getData(
        url: url,
        token: SharedPreferencesHelper.getData(key: 'vewToken'),
      ).then((value) {
        nearesetGasStationResponse =
            NearesetGasStationResponse.fromJson(value.data);
        emit(GetAllGasStationSuccessState(
            nearesetGasStationResponse!.gasStations!));
      }).onError((error, stackTrace) {
        emit(GetAllGasStationErrorState());
      });
    } else {
      emit(GetAllGasStationSuccessState(
          nearesetGasStationResponse!.gasStations!));
    }
  }

  Future getAllMaintenanceCenter() async {
    String url = "/admin/maintenanceCenter/";
    emit(GetAllMCLoadingState());
    if (nearesetMCResponse == null) {
      await DioHelper.getData(
        url: url,
        token: SharedPreferencesHelper.getData(key: 'vewToken'),
      ).then((value) {
        nearesetMCResponse = NearesetMCResponse.fromJson(value.data);
        emit(GetAllMCSuccessState(nearesetMCResponse!.maintenanceCenter!));
      }).onError((error, stackTrace) {
        emit(GetAllMCErrorState());
      });
    } else {
      emit(GetAllMCSuccessState(nearesetMCResponse!.maintenanceCenter!));
    }
  }

  Future<void> getUserWithId(String id, String role) async {
    emit(GetUserWithIdLoadingState());
    await DioHelper.getData(url: "/admin/${id}").then((value) {
      if (role == "mechanic") {
        mechanicShop = MechanicShop.fromJson(value.data["data"]);
        emit(GetMechanicWithIdSuccessState(mechanicShop!));
      } else if (role == "winch") {
        winchDriver = WinchDriver.fromJson(value.data["data"]);
        emit(GetWinchWithIdSuccessState(winchDriver!));
      } else if (role == "user") {
        driver = Driver.fromJson(value.data["data"]);
        emit(GetDriverWithIdSuccessState(driver!));
      }
    }).onError((error, stackTrace) {
      emit(GetUserWithIdErrorState());
    });
  }
}

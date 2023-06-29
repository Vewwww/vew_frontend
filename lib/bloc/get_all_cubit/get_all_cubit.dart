import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/sp_helper/cache_helper.dart';
import '../../model/driver.dart';
import '../../model/mechanic_shop.dart';
import '../../model/winch_driver.dart';
import '../../services/dio_helper.dart';

part 'get_all_state.dart';

class GetAllCubit extends Cubit<GetAllState> {

  GetAllCubit() : super(GetAllInitial());
  static GetAllCubit get(context) => BlocProvider.of(context);
  MechnaicShopResponse? mechnaicShopResponse;

  Future getAllMechanicShop() async {
    String url = "/admin/mechanic/";
    emit(GetAllMechanicShopLoadingState());
     await DioHelper.getData(
      url: url,
      token:SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      print("Get all mechanic response : ${value.data}");
       mechnaicShopResponse =
          MechnaicShopResponse.fromJson(value.data);
      emit(GetAllMechanicShopSuccessState(mechnaicShopResponse!.mechanicShop!));
    }).onError((error, stackTrace) {
      print("Get all mechanic error : $error");
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
      print("Get all winch response : ${value.data}");
      WinchDriverResponse winchDriverResponse =
          WinchDriverResponse.fromJson(value.data);
      emit(GetAllWinchDriversSuccessState(winchDriverResponse.winchDriver!));
    }).onError((error, stackTrace) {
      print("Get all winch error : $error");
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
      print("Get all drivers response : ${value.data}");
      DriverResponse driverResponse =
          DriverResponse.fromJson(value.data);
      emit(GetAllDriversSuccessState(driverResponse.driver!));
    }).onError((error, stackTrace) {
      print("Get all drivers error : $error");
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
      print("Get all Admins response : ${value.data}");
      DriverResponse driverResponse =
          DriverResponse.fromJson(value.data);
      emit(GetAllAdminsSuccessState(driverResponse.driver!));
    }).onError((error, stackTrace) {
      print("Get all Admins error : $error");
      emit(GetAllAdminsErrorState());
    });
  }

  Future<void> getUserWithId(String id,String role) async {
    emit(GetUserWithIdLoadingState());
    await DioHelper.getData(url: "/admin/${id}").then((value) {
      print("Get user with Id  response : ${value.data}");
       if(role == "mechanic"){
         MechanicShop mechanicShop = MechanicShop.fromJson(value.data["data"]);
         emit(GetMechanicWithIdSuccessState(mechanicShop));
         print("Mechanic Name ${mechanicShop.name!}");
       }
       else if(role == "winch"){
          WinchDriver winchDriver = WinchDriver.fromJson(value.data["data"]);
          emit(GetWinchWithIdSuccessState(winchDriver));
          print(winchDriver.name!);
       }
       else if(role == "user"){
         driver = Driver.fromJson(value.data["data"]);
         emit(GetDriverWithIdSuccessState(driver));
       }
    }).onError((error, stackTrace) {
      emit(GetUserWithIdErrorState());
      print("Get user with Id error : ${error}");
    });
  }



}

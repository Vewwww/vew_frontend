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

  Future getAllMechanicShop() async {
    String url = "/admin/mechanic/";
    emit(GetAllMechanicShopLoadingState());
    await DioHelper.getData(
      url: url,
      token:SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      print("Get all mechanic response : ${value.data}");
      MechnaicShopResponse mechnaicShopResponse =
          MechnaicShopResponse.fromJson(value.data);
      emit(GetAllMechanicShopSuccessState(mechnaicShopResponse.mechanicShop!));
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
}
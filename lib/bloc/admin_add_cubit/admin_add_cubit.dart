import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/model/repairer.dart';
import 'package:vewww/views/admin/add_maintenance_center_screen.dart';
import '../../core/utils/sp_helper/cache_helper.dart';
import '../../model/driver.dart';
import '../../model/sign_image.dart';
import '../../model/warning_sign.dart';
import '../../services/dio_helper.dart';

part 'admin_add_state.dart';

class AdminAddCubit extends Cubit<AdminAddState> {
  AdminAddCubit() : super(AdminAddInitial());
  static AdminAddCubit get(context) => BlocProvider.of(context);

  void addAdmin(Driver admin) async {
    emit(AddAdminLoadingState());
    print(admin.toJson());
    await DioHelper.postData(
      url: "/admin/",
      data: admin.toJson(),
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      print("Add admin response : ${value}");
      emit(AddAdminSuccessState());
    }).catchError((error){
      if(error is DioError){
        print(error.response);
      }
      emit(AddAdminErrorState());
    });
    
  }

   void addSign(SignImage sign) async {
    emit(AddSignLoadingState());
    print(sign.toJson());
    await DioHelper.postData(
      url: "/sign/",
      data: sign.toJson(),
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      print("Add sign response : ${value}");
      emit(AddSignSuccessState());
    }).catchError((err) {
      if (err is DioError) {
        print(err.response);
        emit(AddSignErrorState());
      }
      print(err.toString());
    });

   }
   void AddMaintenanceCenter(MaintenanceCenter maintenanceCenter) async {
    emit(AddGasStationLoadingState());
    print(maintenanceCenter.toJson());
    await DioHelper.postData(
      url: "/maintenanceCenter/",
      data: maintenanceCenter.toJson(),
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      print("Add maintenanceCenter response : ${value}");
      emit(AddGasStationSuccessState());
    }).catchError((error){
      if(error is DioError){
        print(error.response);
      }
      emit(AddGasStationErrorState());
    });
    
  }

  void AddGasStation(GasStation gasStation) async {
    emit(AddGasStationLoadingState());
    print(gasStation.toJson());
    await DioHelper.postData(
      url: "/admin/gasStation",
      data: gasStation.toJson(),
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      print("Add gasStation response : ${value}");
      emit(AddGasStationSuccessState());
    }).catchError((error){
      if(error is DioError){
        print(error.response);
      }
      emit(AddGasStationErrorState());
    });
    
  }
   }


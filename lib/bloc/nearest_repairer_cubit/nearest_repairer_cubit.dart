import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:vewww/model/nearest_MC_response.dart';
import 'package:vewww/services/dio_helper.dart';

import '../../core/utils/sp_helper/cache_helper.dart';
import '../../model/nearest_gas_station_response.dart';
import '../../model/nearest_mechnaic.dart';
import '../../model/repairer.dart';

part 'nearest_repairer_state.dart';

class NearestRepairerCubit extends Cubit<NearestRepairerState> {
  NearestRepairerCubit() : super(NearestRepairerInitial());
  static NearestRepairerCubit get(context) => BlocProvider.of(context);

  //getNearestMaintainaceCenter
  Future getNearestMC({String? carTypeID, String? isVerified}) async {
    String url = "/driver/maintenanceCenter/getNearestMaintenanceCenters";
    emit(GettingNearestMCLoadingState());
    await DioHelper.getData(
        url: url,
        token: SharedPreferencesHelper.getData(key: 'vewToken'),
        query: {"carType": carTypeID, "isVerified": isVerified}).then((value) {
      print("neareat MC response : ${value.data}");
      NearesetMCResponse nearesetMCResponse =
          NearesetMCResponse.fromJson(value.data);
      emit(GettingNearestMCSuccessState(nearesetMCResponse.maintenanceCenter!));
    }).onError((error, stackTrace) {
      print("neareat MC error : $error");
      emit(GettingNearestMCErrorState());
    });
  }

  Future getNearestGasStation() async {
    String url = "/gasStation/";
    emit(GettingNearestGasStationLoadingState());
    await DioHelper.getData(
      url: url,
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      print("neareat gas station response : ${value.data}");
      NearesetGasStationResponse nearesetGasStationResponse =
          NearesetGasStationResponse.fromJson(value.data);
      emit(GettingNearestGasStationSuccessState(
          nearesetGasStationResponse.gasStation!));
    }).onError((error, stackTrace) {
      print("neareat gas station error : $error");
      emit(GettingNearestGasStationErrorState());
    });
  }

  Future getNearestMechanic(String serviceId) async {
    String url = "/mechanic/getNearestMechanicWorkshop?service=${serviceId}";
    emit(GettingNearestMechanicLoadingState());
    await DioHelper.getData(
      url: url,
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      print("neareat mechanic response : ${value.data}");
      NearestMechanicResponse nearesetMechanicResponse =
          NearestMechanicResponse.fromJson(value.data);
      emit(GettingNearestMechanicSuccessState(
          mechanics: nearesetMechanicResponse.mechanic!));
    }).onError((error, stackTrace) {
      print("neareat mechanic error : ${error}");
      emit(GettingNearestMechanicErrorState());
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:vewww/model/nearest_MC_response.dart';
import 'package:vewww/model/nearest_winch.dart';
import 'package:vewww/services/dio_helper.dart';
import '../../core/utils/sp_helper/cache_helper.dart';
import '../../model/nearest_gas_station_response.dart';
import '../../model/nearest_mechnaic.dart';
import '../../model/nearest_repairer_response.dart';
import '../../model/repairer.dart';
part 'nearest_repairer_state.dart';

class NearestRepairerCubit extends Cubit<NearestRepairerState> {
  NearestRepairerCubit() : super(NearestRepairerInitial());
  static NearestRepairerCubit get(context) => BlocProvider.of(context);
  NearesetMCResponse? nearesetMCResponse;
  NearestMechanicResponse? nearesetMechanicResponse;
  NearesetGasStationResponse? nearesetGasStationResponse;

  Future getNearestMC({String? carTypeID, String? isVerified}) async {
    String url = (carTypeID == null)
        ? "/driver/getNearestMaintenanceCenters/"
        : "/driver/getNearestMaintenanceCenters?carType=$carTypeID";
    Map<String, dynamic> query = await getCurrentLocation();
    emit(GettingNearestMCLoadingState());
    await DioHelper.getWithBody(
            url: url,
            token: SharedPreferencesHelper.getData(key: 'vewToken'),
            query: query)
        .then((value) {
      NearesetMCResponse nearesetMCResponse =
          NearesetMCResponse.fromJson(value.data);
      emit(GettingNearestMCSuccessState(nearesetMCResponse.maintenanceCenter!));
    }).catchError((error) {
      emit(GettingNearestMCErrorState());
    });
  }

  Future getNearestGasStation() async {
    String url = "/driver/getNearestGasStations";
    Map<String, dynamic> query = await getCurrentLocation();
    emit(GettingNearestGasStationLoadingState());
    if (nearesetGasStationResponse == null) {
      await DioHelper.getWithBody(
        url: url,
        query: query,
        token: SharedPreferencesHelper.getData(key: 'vewToken'),
      ).then((value) {
        NearesetGasStationResponse nearesetGasStationResponse =
            NearesetGasStationResponse.fromJson(value.data);
        emit(GettingNearestGasStationSuccessState(
            nearesetGasStationResponse.gasStations!));
      }).catchError((error) {
        emit(GettingNearestGasStationErrorState());
      });
    } else {
      emit(GettingNearestGasStationSuccessState(
          nearesetGasStationResponse!.gasStations!));
    }
  }

  Future getNearestMechanic(String serviceId) async {
    String url = "/driver/getNearestMechanicWorkshop?service=$serviceId";
    Map<String, dynamic> query = await getCurrentLocation();
    emit(GettingNearestMechanicLoadingState());
    if (nearesetMechanicResponse == null) {
      await DioHelper.getWithBody(
        url: url,
        query: query,
        token: SharedPreferencesHelper.getData(key: 'vewToken'),
      ).then((value) {
        NearestMechanicResponse nearesetMechanicResponse =
            NearestMechanicResponse.fromJson(value.data);
        emit(GettingNearestMechanicSuccessState(
            mechanics: nearesetMechanicResponse.mechanic!));
      }).onError((error, stackTrace) {
        emit(GettingNearestMechanicErrorState());
      });
    } else {
      emit(GettingNearestMechanicSuccessState(
          mechanics: nearesetMechanicResponse!.mechanic!));
    }
  }

  Future getNearestWinch() async {
    String url = "/driver/getNearestWinch";
    Map<String, dynamic> query = await getCurrentLocation();
    emit(GettingNearestWinchLoadingState());
    await DioHelper.getWithBody(
      url: url,
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
      query: query,
    ).then((value) {
      NearestWinchResponse nearestWinchResponse =
          NearestWinchResponse.fromJson(value.data);
      emit(GettingNearestWinchSuccessState(
          nearestWinch: nearestWinchResponse.nearestWinch!));
    }).catchError((error) {
      emit(GettingNearestWinchErrorState());
    });
  }

  //get nearest repairer gas station , MC , mechanic
  Future getNearest() async {
    Map<String, dynamic> query = await getCurrentLocation();
    await DioHelper.getWithBody(
      url: "/driver/getNearest",
      query: query,
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      NearesetPlaceResponse nearesetPlaceResponse =
          NearesetPlaceResponse.fromJson(value.data);
      emit(GettingNearestSuccessState(places: nearesetPlaceResponse.places!));
    }).onError((error, stackTrace) {
      emit(GettingNearestErrorState());
    });
  }

  Future search(String searchKey) async {
    Map<String, dynamic> query = await getCurrentLocation();
    String url = "/driver/search?keyword=$searchKey";
    emit(SearchLoadingState());
    await DioHelper.getWithBody(
      url: url,
      query: query,
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      NearesetPlaceResponse nearesetPlaceResponse =
          NearesetPlaceResponse.fromJson(value.data);
      emit(SearchSuccessState(places: nearesetPlaceResponse.places!));
    }).onError((error, stackTrace) {
      emit(SearchErrorState());
    });
  }

  Future<Map<String, dynamic>> getCurrentLocation() async {
    LocationPermission locationPermission;
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    //check if user enable service for location permission
    if (!isLocationServiceEnabled) {
      debugPrint("user don't enable location permission");
    }

    locationPermission = await Geolocator.checkPermission();

    //check if user denied location and retry requesting for permission
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        debugPrint("user denied location permission");
      }
    }

    //check if user denied permission forever
    if (locationPermission == LocationPermission.deniedForever) {
      debugPrint("user denied permission forever");
    }

    var location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    return {"latitude": location.latitude, "longitude": location.latitude};
  }
}

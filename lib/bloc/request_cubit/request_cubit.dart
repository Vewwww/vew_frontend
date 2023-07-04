import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../core/utils/sp_helper/cache_helper.dart';
import '../../model/name.dart';
import '../../model/requests.dart';
import '../../services/dio_helper.dart';
import '../../model/location.dart' as loc;
part 'request_state.dart';

class RequestCubit extends Cubit<RequestState> {
  RequestCubit() : super(RequestInitial());
  static RequestCubit get(context) => BlocProvider.of(context);
  RequestResponse? reqResponse;

  Future<void> getDriverPrevReq() async {
    emit(GetDriverPrevReqLoadingState());
    DioHelper.getData(url: "/driver/request/previousRequests/").then((value) {
      print("get pervious req response : ${value.data}");
      reqResponse = RequestResponse.fromJson(value.data);
      emit(GetDriverPrevReqSuccessState(reqResponse!.previousRequests!));
    }).catchError((error) {
      if (error is DioError) {
        print(error.response);
      }
      print(error);
      emit(GetDriverPrevReqErrorState());
    });
  }

  Future<void> getDriverCurrentReq() async {
    emit(GetDriverCurrentReqLoadingState());
    DioHelper.getData(url: "/driver/request/getDriverCurrentRequests/")
        .then((value) {
      print("get Curr req response : ${value.data}");
      RequestResponse currentReqResponse = RequestResponse.fromJson(value.data);
      print("get Curr req done");

      emit(GetDriverReqSuccessState(currentReqResponse.previousRequests!));
    }).catchError((error) {
      if (error is DioError) {
        print(error.response);
      }
      print(error);
      emit(GetDriverCurrentReqErrorState());
    });
  }

  Future<void> getDriverPendingReq() async {
    emit(GetDriverPendingReqLoadingState());
    DioHelper.getData(url: "/driver/request/getDriverPendingRequests/")
        .then((value) {
      print("get Pending req response : ${value.data}");
      RequestResponse PendingReqResponse = RequestResponse.fromJson(value.data);
      emit(GetDriverReqSuccessState(PendingReqResponse.previousRequests!));
    }).catchError((error) {
      if (error is DioError) {
        print(error.response);
      }
      print(error);
      emit(GetDriverPendingReqErrorState());
    });
  }

  Future<void> cancelRequest(String id) async {
    String url = "/driver/request/:$id";
    emit(CancelRequestLoadingState());
    DioHelper.deleteData(url: url).then((value) {
      emit(CancelRequestSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        print(error.response);
      }
      print(error);
      emit(CancelRequestErrorState());
    });
  }

  void createWinchRequest(CreateRequest createRequest) async {
    emit(CreateWinchRequestLoadingState());
    print(createRequest.toJsonRequest());
    await DioHelper.postData(
      url: "/driver/createWinchRequest/",
      data: createRequest.toJsonRequest(),
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      print("request winch response : ${value}");
      emit(CreateWinchRequestSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        print("create winch request error  :${error.response}");
      }
      emit(CreateWinchRequestErrorState());
    });
  }

  void createMechanicRequest(CreateRequest createRequest) async {
    emit(CreateMechanicRequestLoadingState());
    print(createRequest.toJson());
    await DioHelper.postData(
      url: "/driver/createMechanicRequest/",
      data: createRequest.toJson(),
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      print("Request mechanic response : ${value}");
      emit(CreateMechanicRequestSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        print(error.response);
      }
      emit(CreateMechanicRequestErrorState());
    });
  }

  // Future<loc.Location> getLocation() async {
  //   LocationPermission locationPermission;
  //   bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
  //   //check if user enable service for location permission
  //   if (!isLocationServiceEnabled) {
  //     debugPrint("user don't enable location permission");
  //   }

  //   locationPermission = await Geolocator.checkPermission();

  //   //check if user denied location and retry requesting for permission
  //   if (locationPermission == LocationPermission.denied) {
  //     locationPermission = await Geolocator.requestPermission();
  //     if (locationPermission == LocationPermission.denied) {
  //       debugPrint("user denied location permission");
  //     }
  //   }

  //   //check if user denied permission forever
  //   if (locationPermission == LocationPermission.deniedForever) {
  //     debugPrint("user denied permission forever");
  //   }

  //   var currentLocation = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.best);
  //   List<Placemark> placeMark = await placemarkFromCoordinates(
  //       currentLocation.latitude, currentLocation.longitude);
  //   Placemark address = placeMark[0];
  //   String? road = address.street;
  //   loc.Location location = loc.Location(
  //       longitude: currentLocation.longitude,
  //       latitude: currentLocation.latitude,

  //       description: Name(en:road , ar:road));

  //   return  location;
  // }
}

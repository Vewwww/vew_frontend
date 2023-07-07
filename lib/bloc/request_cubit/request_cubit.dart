import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/sp_helper/cache_helper.dart';
import '../../model/requests.dart';
import '../../services/dio_helper.dart';
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
      RequestResponse reqResponse = RequestResponse.fromJson(value.data);
      print("get Curr req done");

      emit(GetDriverReqSuccessState(reqResponse.previousRequests!));
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
      this.reqResponse = RequestResponse.fromJson(value.data);
      print("done PendingReqResponse ");
      emit(GetDriverReqSuccessState(reqResponse!.previousRequests!));
    }).catchError((error) {
      if (error is DioError) {
        print(error.response);
      }
      print(error);
      emit(GetDriverPendingReqErrorState());
    });
  }

  Future<void> cancelRequest(String id) async {
    String url = "/driver/request/$id";
    emit(CancelRequestLoadingState());
    DioHelper.deleteData(url: url).then((value) {
      print("cancel request res :  ${value.data}");
      
      emit(CancelRequestSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        print("cancel request error :  ${error.response}");
      }
      print(error);
      emit(CancelRequestErrorState());
    });
  }

  Future<void> createWinchRequest(CreateRequest createRequest) async {
    emit(CreateWinchRequestLoadingState());
    print(createRequest.toJsonRequest());
    await DioHelper.postData(
      url: "/driver/createWinchRequest/",
      data: await createRequest.toJsonRequest(),
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      print("request winch response : ${value}");
      emit(CreateWinchRequestSuccessState(value.data["data"]['_id']));
    }).catchError((error) {
      if (error is DioError) {
        print("create winch request error  :${error.response}");
      }
      emit(CreateWinchRequestErrorState());
    });
  }

  Future<void> createMechanicRequest(CreateRequest createRequest) async {
    emit(CreateMechanicRequestLoadingState());
    print("in create mechanic request ${createRequest.toJsonRequest()}");
    await DioHelper.postData(
      url: "/driver/createMechanicRequest/",
      data: await createRequest.toJsonRequest(),
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      print("Request mechanic response : ${value}");

      emit(CreateMechanicRequestSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        print(error.response);
      }
      print(error);

      emit(CreateMechanicRequestErrorState());
    });
  }
}

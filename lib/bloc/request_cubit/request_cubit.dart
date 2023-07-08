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

  //get previous requests for user
  Future<void> getDriverPrevReq() async {
    emit(GetDriverPrevReqLoadingState());
    DioHelper.getData(url: "/driver/request/previousRequests/").then((value) {
      reqResponse = RequestResponse.fromJson(value.data);
      emit(GetDriverPrevReqSuccessState(reqResponse!.previousRequests!));
    }).catchError((error) {
      emit(GetDriverPrevReqErrorState());
    });
  }

  Future<void> getDriverCurrentReq() async {
    emit(GetDriverCurrentReqLoadingState());
    DioHelper.getData(url: "/driver/request/getDriverCurrentRequests/")
        .then((value) {
      RequestResponse reqResponse = RequestResponse.fromJson(value.data);

      emit(GetDriverReqSuccessState(reqResponse.previousRequests!));
    }).catchError((error) {
      emit(GetDriverCurrentReqErrorState());
    });
  }

  Future<void> getDriverPendingReq() async {
    emit(GetDriverPendingReqLoadingState());
    DioHelper.getData(url: "/driver/request/getDriverPendingRequests/")
        .then((value) {
      reqResponse = RequestResponse.fromJson(value.data);
      emit(GetDriverReqSuccessState(reqResponse!.previousRequests!));
    }).catchError((error) {
      emit(GetDriverPendingReqErrorState());
    });
  }

  // driver cancel pendding or current request
  Future<void> cancelRequest(String id) async {
    String url = "/driver/request/$id";
    emit(CancelRequestLoadingState());
    DioHelper.deleteData(url: url).then((value) { 
      emit(CancelRequestSuccessState());
    }).catchError((error) {
      emit(CancelRequestErrorState());
    });
  }

  Future<void> createWinchRequest(CreateRequest createRequest) async {
    emit(CreateWinchRequestLoadingState());
    await DioHelper.postData(
      url: "/driver/createWinchRequest/",
      data: await createRequest.toJsonRequest(),
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      emit(CreateWinchRequestSuccessState(value.data["data"]['_id']));
    }).catchError((error) {
      emit(CreateWinchRequestErrorState());
    });
  }

  Future<void> createMechanicRequest(CreateRequest createRequest) async {
    emit(CreateMechanicRequestLoadingState());
    await DioHelper.postData(
      url: "/driver/createMechanicRequest/",
      data: await createRequest.toJsonRequest(),
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {

      emit(CreateMechanicRequestSuccessState());
    }).catchError((error) {
      emit(CreateMechanicRequestErrorState());
    });
  }
}

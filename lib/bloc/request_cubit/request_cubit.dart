import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/model/requests.dart';

import '../../services/dio_helper.dart';

part 'request_state.dart';

class RequestCubit extends Cubit<RequestState> {
  RequestCubit() : super(RequestInitial());
  static RequestCubit get(context) => BlocProvider.of(context);
  PreviousRequestResponse? prevReqResponse;

  Future<void> getDriverPrevReq() async{
    emit(GetDriverPrevReqLoadingState());
  if (PreviousRequestResponse != null) {
      DioHelper.getData(url: "/driver/request/previousRequests/").then((value) {
        print("get pervious req response : ${value.data}");
        prevReqResponse=PreviousRequestResponse.fromJson(value.data);
        emit(GetDriverPrevReqSuccessState(prevReqResponse!.previousRequests!));
      }).catchError((error){
      if(error is DioError){
        print(error.response);
      }
      print(error);
      emit(GetDriverPrevReqErrorState());
    });
    } else {
      emit(GetDriverPrevReqSuccessState(prevReqResponse!.previousRequests!));
    }
  }
}

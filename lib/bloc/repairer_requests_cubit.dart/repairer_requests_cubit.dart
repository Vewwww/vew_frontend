import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:vewww/services/dio_helper.dart';

import '../../core/utils/sp_helper/cache_helper.dart';
import '../../model/accepted_requests_response.dart';
import '../../model/upcoming_requests_response.dart';

part 'repairer_requests_state.dart';

class RepairerRequestsCubit extends Cubit<RepairerRequestsState> {
  RepairerRequestsCubit() : super(RepairerRequestsInitial());
  static RepairerRequestsCubit get(context) => BlocProvider.of(context);
  AcceptedRequestsResponse? acceptedRequestsResponse;
  UpcomingRequestsResponse? upcomingRequestsResponse;

  Future<void> mechanicAcceptedRequests() async {
    emit(GettingAcceptedRequestsLoadingState());
    await DioHelper.getData(
      url: "/mechanic/geteMchanicAcceptedRequests",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      print("geteMchanicAcceptedRequests response : ${value.data}");
      acceptedRequestsResponse = AcceptedRequestsResponse.fromJson(value.data);
      emit(GettingAcceptedRequestsSuccessState());
    }).catchError((err) {
      if (err is DioError) print(err.response);
      print(err);
      emit(GettingAcceptedRequestsErrorState());
    });
  }

  Future<void> mechanicUpComingRequests() async {
    emit(GettingUpComingRequestsLoadingState());
    await DioHelper.getData(
      url: "/mechanic/getMechanicUpcomingRequests",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      print("getMechanicUpcomingRequests response : ${value.data}");
      upcomingRequestsResponse = UpcomingRequestsResponse.fromJson(value.data);

      emit(GettingUpComingRequestsSuccessState());
    }).catchError((err) {
      if (err is DioError) print(err.response);
      print(err);
      emit(GettingUpComingRequestsErrorState());
    });
  }

  Future<void> mechanicCancelRequest(String id) async {
    emit(CancelingRequestLoadingState());
    await DioHelper.deleteData(
      url: "/mechanic/request/$id",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      print("canceling mech requests response : ${value.data}");
      mechanicUpComingRequests();
      emit(CancelingRequestSuccessState());
    }).catchError((err) {
      if (err is DioError) print(err.response);
      print(err);
      emit(CancelingRequestErrorState());
    });
  }

  Future<void> mechanicAcceptRequest(String id) async {
    emit(AcceptingRequestLoadingState());
    await DioHelper.getData(
      url: "/mechanic/acceptMechanicRequest/$id",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      print("canceling mech requests response : ${value.data}");
      mechanicAcceptedRequests();
      emit(AcceptingRequestSuccessState());
    }).catchError((err) {
      if (err is DioError) print(err.response);
      print(err);
      emit(AcceptingRequestErrorState());
    });
  }

  Future<void> mechanicCompleteRequest(String id) async {
    emit(CompletingRequestLoadingState());
    await DioHelper.getData(
      url: "/mechanic/endRequest/$id",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      print("completing mech requests response : ${value.data}");
      mechanicAcceptedRequests();
      emit(CompletingRequestSuccessState());
    }).catchError((err) {
      if (err is DioError) print(err.response);
      print(err);
      emit(CompletingRequestErrorState());
    });
  }
}
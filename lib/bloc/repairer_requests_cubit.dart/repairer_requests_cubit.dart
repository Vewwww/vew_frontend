import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/bloc/new_request_cubit/new_request_cubit.dart';
import 'package:vewww/model/winch_upcoming_request_response.dart';
import 'package:vewww/services/dio_helper.dart';

import '../../core/utils/sp_helper/cache_helper.dart';
import '../../model/accepted_requests_response.dart';
import '../../model/upcoming_requests_response.dart';
import '../../model/winch_accepted_requests_response.dart';

part 'repairer_requests_state.dart';

class RepairerRequestsCubit extends Cubit<RepairerRequestsState> {
  RepairerRequestsCubit() : super(RepairerRequestsInitial());
  static RepairerRequestsCubit get(context) => BlocProvider.of(context);
  MechanicAcceptedRequestsResponse? acceptedRequestsResponse;
  UpcomingRequestsResponse? upcomingRequestsResponse;
  WinchAcceptedRequestsResponse? winchacceptedRequestsResponse;

  Future<void> mechanicAcceptedRequests() async {
    emit(GettingAcceptedRequestsLoadingState());
    await DioHelper.getData(
      url: "/mechanic/geteMchanicAcceptedRequests",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      print("geteMchanicAcceptedRequests response : ${value.data}");
      acceptedRequestsResponse =
          MechanicAcceptedRequestsResponse.fromJson(value.data);
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

  Future<void> winchAcceptedRequests() async {
    emit(GettingWinchAcceptedRequestsLoadingState());
    await DioHelper.getData(
      url: "/winch/getWinchAcceptedRequests",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      print("GettingWinchAcceptedRequests response : ${value.data}");
      winchacceptedRequestsResponse =
          WinchAcceptedRequestsResponse.fromJson(value.data);
      emit(GettingWinchAcceptedRequestsSuccessState());
    }).catchError((err) {
      if (err is DioError) print(err.response);
      print(err);
      emit(GettingWinchAcceptedRequestsErrorState());
    });
  }

  Future<void> winchUpComingRequests() async {
    emit(GettingWinchUpComingRequestsLoadingState());
    await DioHelper.getData(
      url: "/winch/getWinchUpcomingRequests",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      print("winchUpComingRequests response : ${value.data}");
      WinchUpcomingRequestResponse winchUpcomingRequestResponse =
          WinchUpcomingRequestResponse.fromJson(value.data);
      emit(GettingWinchUpComingRequestsSuccessState(
          winchUpcomingRequestResponse.data!));
    }).catchError((err) {
      if (err is DioError) print(err.response);
      print(err);
      emit(GettingWinchUpComingRequestsErrorState());
    });
  }

  Future<void> winchCancelRequest(String id) async {
    emit(WinchCancelingRequestLoadingState());
    await DioHelper.deleteData(
      url: "/winch/request/$id",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      print("canceling winch requests response : ${value.data}");
      winchUpComingRequests();
      emit(WinchCancelingRequestSuccessState());
    }).catchError((err) {
      if (err is DioError) print(err.response);
      print(err);
      emit(WinchCancelingRequestErrorState());
    });
  }

  Future<void> winchAcceptRequest(String id) async {
    emit(WinchAcceptingRequestLoadingState());
    await DioHelper.getData(
      url: "/winch/acceptWinchRequest/$id",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      print("winch accept requests response : ${value.data}");
      //winchAcceptedRequests();
      emit(WinchAcceptingRequestSuccessState());
    }).catchError((err) {
      if (err is DioError) print(err.response);
      print(err);
      emit(WinchAcceptingRequestErrorState());
    });
  }

  Future<void> winchCompleteRequest(String id) async {
    emit(WinchCompletingRequestLoadingState());
    print("winch id from complete $id");
    await DioHelper.getData(
      url: "/winch/endRequest/$id",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      print("completing winch requests response : ${value.data}");
      winchAcceptedRequests();
      emit(WinchCompletingRequestSuccessState());
    }).catchError((err) {
      if (err is DioError) print(err.response);
      print(err);
      emit(WinchCompletingRequestErrorState());
    });
  }
}

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      acceptedRequestsResponse =
          MechanicAcceptedRequestsResponse.fromJson(value.data);
      emit(GettingAcceptedRequestsSuccessState());
    }).catchError((err) {
      emit(GettingAcceptedRequestsErrorState());
    });
  }

  Future<void> mechanicUpComingRequests() async {
    emit(GettingUpComingRequestsLoadingState());
    await DioHelper.getData(
      url: "/mechanic/getMechanicUpcomingRequests",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      upcomingRequestsResponse = UpcomingRequestsResponse.fromJson(value.data);
      emit(GettingUpComingRequestsSuccessState());
    }).catchError((err) {
      emit(GettingUpComingRequestsErrorState());
    });
  }

  Future<void> mechanicCancelRequest(String id) async {
    emit(CancelingRequestLoadingState());
    await DioHelper.deleteData(
      url: "/mechanic/request/$id",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      mechanicUpComingRequests();
      emit(CancelingRequestSuccessState());
    }).catchError((err) {
      emit(CancelingRequestErrorState());
    });
  }

  Future<void> mechanicAcceptRequest(String id) async {
    emit(AcceptingRequestLoadingState());
    await DioHelper.getData(
      url: "/mechanic/acceptMechanicRequest/$id",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      mechanicAcceptedRequests();
      emit(AcceptingRequestSuccessState());
    }).catchError((err) {
      emit(AcceptingRequestErrorState());
    });
  }

  //set request state to done
  Future<void> mechanicCompleteRequest(String id) async {
    emit(CompletingRequestLoadingState());
    await DioHelper.getData(
      url: "/mechanic/endRequest/$id",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      mechanicAcceptedRequests();
      emit(CompletingRequestSuccessState());
    }).catchError((err) {
      emit(CompletingRequestErrorState());
    });
  }

  Future<void> winchAcceptedRequests() async {
    emit(GettingWinchAcceptedRequestsLoadingState());
    await DioHelper.getData(
      url: "/winch/getWinchAcceptedRequests",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      winchacceptedRequestsResponse =
          WinchAcceptedRequestsResponse.fromJson(value.data);
      emit(GettingWinchAcceptedRequestsSuccessState());
    }).catchError((err) {
      emit(GettingWinchAcceptedRequestsErrorState());
    });
  }

  Future<void> winchUpComingRequests() async {
    emit(GettingWinchUpComingRequestsLoadingState());
    await DioHelper.getData(
      url: "/winch/getWinchUpcomingRequests",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      WinchUpcomingRequestResponse winchUpcomingRequestResponse =
          WinchUpcomingRequestResponse.fromJson(value.data);
      emit(GettingWinchUpComingRequestsSuccessState(
          winchUpcomingRequestResponse.data!));
    }).catchError((err) {
      emit(GettingWinchUpComingRequestsErrorState());
    });
  }

  Future<void> winchCancelRequest(String id) async {
    emit(WinchCancelingRequestLoadingState());
    await DioHelper.deleteData(
      url: "/winch/request/$id",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      winchUpComingRequests();
      emit(WinchCancelingRequestSuccessState());
    }).catchError((err) {
      emit(WinchCancelingRequestErrorState());
    });
  }

  Future<void> winchAcceptRequest(String id) async {
    emit(WinchAcceptingRequestLoadingState());
    await DioHelper.getData(
      url: "/winch/acceptWinchRequest/$id",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      emit(WinchAcceptingRequestSuccessState());
    }).catchError((err) {
      emit(WinchAcceptingRequestErrorState());
    });
  }

  //set request state to done
  Future<void> winchCompleteRequest(String id) async {
    emit(WinchCompletingRequestLoadingState());
    await DioHelper.getData(
      url: "/winch/endRequest/$id",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      winchAcceptedRequests();
      emit(WinchCompletingRequestSuccessState());
    }).catchError((err) {
      emit(WinchCompletingRequestErrorState());
    });
  }
}

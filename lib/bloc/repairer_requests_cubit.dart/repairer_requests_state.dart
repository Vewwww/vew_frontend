part of 'repairer_requests_cubit.dart';

abstract class RepairerRequestsState {}

class RepairerRequestsInitial extends RepairerRequestsState {}

class GettingAcceptedRequestsLoadingState extends RepairerRequestsState {}

class GettingAcceptedRequestsSuccessState extends RepairerRequestsState {}

class GettingAcceptedRequestsErrorState extends RepairerRequestsState {}

class GettingUpComingRequestsLoadingState extends RepairerRequestsState {}

class GettingUpComingRequestsSuccessState extends RepairerRequestsState {}

class GettingUpComingRequestsErrorState extends RepairerRequestsState {}

class CompletingRequestLoadingState extends RepairerRequestsState {}

class CompletingRequestSuccessState extends RepairerRequestsState {}

class CompletingRequestErrorState extends RepairerRequestsState {}
class CancelingRequestLoadingState extends RepairerRequestsState {}

class CancelingRequestSuccessState extends RepairerRequestsState {}

class CancelingRequestErrorState extends RepairerRequestsState {}
class AcceptingRequestLoadingState extends RepairerRequestsState {}

class AcceptingRequestSuccessState extends RepairerRequestsState {}

class AcceptingRequestErrorState extends RepairerRequestsState {}

class GettingWinchAcceptedRequestsLoadingState extends RepairerRequestsState {}

class GettingWinchAcceptedRequestsSuccessState extends RepairerRequestsState {}

class GettingWinchAcceptedRequestsErrorState extends RepairerRequestsState {}

class GettingWinchUpComingRequestsLoadingState extends RepairerRequestsState {}

class GettingWinchUpComingRequestsSuccessState extends RepairerRequestsState {
  List<WinchRequestData> requestData;
  GettingWinchUpComingRequestsSuccessState(this.requestData);
}

class GettingWinchUpComingRequestsErrorState extends RepairerRequestsState {}

class WinchAcceptingRequestLoadingState extends RepairerRequestsState {}

class WinchAcceptingRequestSuccessState extends RepairerRequestsState {}

class WinchAcceptingRequestErrorState extends RepairerRequestsState {}

class WinchCompletingRequestLoadingState extends RepairerRequestsState {}

class WinchCompletingRequestSuccessState extends RepairerRequestsState {}

class WinchCompletingRequestErrorState extends RepairerRequestsState {}

class WinchCancelingRequestLoadingState extends RepairerRequestsState {}

class WinchCancelingRequestSuccessState extends RepairerRequestsState {}

class WinchCancelingRequestErrorState extends RepairerRequestsState {}


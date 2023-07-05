part of 'request_cubit.dart';

abstract class RequestState {}

class RequestInitial extends RequestState {}

class GetDriverPrevReqLoadingState extends RequestState {}

class GetDriverPrevReqSuccessState extends RequestState {
  final List<Request> previousRequests;
  GetDriverPrevReqSuccessState(this.previousRequests);
}

class GetDriverPrevReqErrorState extends RequestState {}

class GetDriverCurrentReqLoadingState extends RequestState {}

class GetDriverCurrentReqSuccessState extends RequestState {
  final List<Request> previousRequests;
  GetDriverCurrentReqSuccessState(this.previousRequests);
}

class GetDriverCurrentReqErrorState extends RequestState {}

class GetDriverPendingReqLoadingState extends RequestState {}

class GetDriverReqSuccessState extends RequestState {
  final List<Request> previousRequests;
  GetDriverReqSuccessState(this.previousRequests);
}

class GetDriverPendingReqErrorState extends RequestState {}

class CancelRequestLoadingState extends RequestState {}

class CancelRequestSuccessState extends RequestState {}

class CancelRequestErrorState extends RequestState {}

class CreateWinchRequestLoadingState extends RequestState {}

class CreateWinchRequestSuccessState extends RequestState {
  final String requestId;
  CreateWinchRequestSuccessState(this.requestId);
}

class CreateWinchRequestErrorState extends RequestState {}

class CreateMechanicRequestLoadingState extends RequestState {}

class CreateMechanicRequestSuccessState extends RequestState {}

class CreateMechanicRequestErrorState extends RequestState {}

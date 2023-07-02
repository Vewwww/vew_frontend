part of 'request_cubit.dart';

abstract class RequestState {}

class RequestInitial extends RequestState {}
class GetDriverPrevReqLoadingState extends RequestState {}
class GetDriverPrevReqSuccessState extends RequestState {
  final List<PreviousRequest> previousRequests;
  GetDriverPrevReqSuccessState(this.previousRequests);
}
class GetDriverPrevReqErrorState extends RequestState {}

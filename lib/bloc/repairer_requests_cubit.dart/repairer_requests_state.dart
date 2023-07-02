part of 'repairer_requests_cubit.dart';

@immutable
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

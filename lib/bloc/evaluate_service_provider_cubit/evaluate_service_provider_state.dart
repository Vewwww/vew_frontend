part of 'evaluate_service_provider_cubit.dart';

abstract class EvaluateServiceProviderState {}

class EvaluateServiceProviderInitial extends EvaluateServiceProviderState {}

class ReportWinchLoadingState extends EvaluateServiceProviderState {}
class ReportWinchSuccessState extends EvaluateServiceProviderState {}
class ReportWinchErrorState extends EvaluateServiceProviderState {}

class ReportMechanicLoadingState extends EvaluateServiceProviderState {}
class ReportMechanicSuccessState extends EvaluateServiceProviderState {}
class ReportMechanicErrorState extends EvaluateServiceProviderState {}

class RateMechanicLoadingState extends EvaluateServiceProviderState {}
class RateMechanicSuccessState extends EvaluateServiceProviderState {}
class RateMechanicErrorState extends EvaluateServiceProviderState {}

class RateWinchLoadingState extends EvaluateServiceProviderState {}
class RateWinchSuccessState extends EvaluateServiceProviderState {}
class RateWinchErrorState extends EvaluateServiceProviderState {}
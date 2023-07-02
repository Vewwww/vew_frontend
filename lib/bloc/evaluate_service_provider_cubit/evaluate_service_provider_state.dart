part of 'evaluate_service_provider_cubit.dart';

@immutable
abstract class EvaluateServiceProviderState {}

class EvaluateServiceProviderInitial extends EvaluateServiceProviderState {}

class ReportWinchLoadingState extends EvaluateServiceProviderState {}
class ReportWinchSuccessState extends EvaluateServiceProviderState {}
class ReportWinchErrorState extends EvaluateServiceProviderState {}
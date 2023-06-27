part of 'admin_analysis_cubit.dart';

@immutable
abstract class AdminAnalysisState {}

class AdminAnalysisInitial extends AdminAnalysisState {}
class GetUserAnalysisLoadingState extends AdminAnalysisState {}
class GetUserAnalysisSuccessState extends AdminAnalysisState {
  final UserAnalysisResponse userAnalysisResponse;
  GetUserAnalysisSuccessState(this.userAnalysisResponse);
}
class GetUserAnalysisErrorState extends AdminAnalysisState {}

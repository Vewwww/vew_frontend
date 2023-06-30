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

class GetGenderAnalysisLoadingState extends AdminAnalysisState {}
class GetGenderrAnalysisSuccessState extends AdminAnalysisState {
  final GenderAnalysisResponse genderAnalysisResponse;
  GetGenderrAnalysisSuccessState(this.genderAnalysisResponse);
}
class GetGenderAnalysisErrorState extends AdminAnalysisState {}


class GetSeasonAnalysisLoadingState extends AdminAnalysisState {}
class GetSeasonAnalysisSuccessState extends AdminAnalysisState {
  final SeasonAnalysisResponse seasonAnalysisResponse;
  GetSeasonAnalysisSuccessState(this.seasonAnalysisResponse);
}
class GetSeasonAnalysisErrorState extends AdminAnalysisState {}
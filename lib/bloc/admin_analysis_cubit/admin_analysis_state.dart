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

class GetCarModelAnalysisLoadingState extends AdminAnalysisState {}
class GetCarModelAnalysisSuccessState extends AdminAnalysisState {
  final List<CarModelAnalysisResponse> carModelAnalysisResponse;
  GetCarModelAnalysisSuccessState(this.carModelAnalysisResponse);
}
class GetCarModelAnalysisErrorState extends AdminAnalysisState {}
class GetRoadAnalysisLoadingState extends AdminAnalysisState {}
class GetRoadAnalysisSuccessState extends AdminAnalysisState {
  final List<RoadAnalysisResponse> roadAnalysisResponses ;
  GetRoadAnalysisSuccessState(this.roadAnalysisResponses);
}
class GetRoadAnalysisErrorState extends AdminAnalysisState {}
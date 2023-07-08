import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:vewww/model/car_mosel_analysis_response.dart';
import 'package:vewww/model/road_analysis_response.dart';

import '../../core/utils/sp_helper/cache_helper.dart';
import '../../model/analysis.dart';
import '../../services/dio_helper.dart';

part 'admin_analysis_state.dart';

class AdminAnalysisCubit extends Cubit<AdminAnalysisState> {
  AdminAnalysisCubit() : super(AdminAnalysisInitial());
  static AdminAnalysisCubit get(context) => BlocProvider.of(context);

  // statistics about percentage of each user type in the app
  Future getUserAnalysis() async {
    String url = "/admin/userStatistics/";
    emit(GetUserAnalysisLoadingState());
    DioHelper.getData(
      url: url,
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      UserAnalysisResponse userAnalysisResponse =
          UserAnalysisResponse.fromJson(value.data);
      emit(GetUserAnalysisSuccessState(userAnalysisResponse));
    }).onError((error, stackTrace) {
      emit(GetUserAnalysisErrorState());
    });
  }

  Future getGenderAnalysis() async {
    String url = "/admin/genderAnalytics/";
    emit(GetGenderAnalysisLoadingState());
    DioHelper.getData(
      url: url,
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      GenderAnalysisResponse genderAnalysisResponse =
          GenderAnalysisResponse.fromJson(value.data);
      emit(GetGenderrAnalysisSuccessState(genderAnalysisResponse));
    }).catchError((error, stackTrace) {
      emit(GetGenderAnalysisErrorState());
    });
  }

  Future getSeasonAnalysis() async {
    String url = "/admin/seasonsAnalytics/";
    emit(GetSeasonAnalysisLoadingState());
    DioHelper.getData(
      url: url,
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      SeasonAnalysisResponse seasonAnalysisResponse =
          SeasonAnalysisResponse.fromJson(value.data);
      emit(GetSeasonAnalysisSuccessState(seasonAnalysisResponse));
    }).onError((error, stackTrace) {
      emit(GetSeasonAnalysisErrorState());
    });
  }

  Future getCarModelAnalysis() async {
    String url = "/admin/topModelsHadIssues/";
    emit(GetCarModelAnalysisLoadingState());
    DioHelper.getData(
      url: url,
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      List<CarModelAnalysisResponse> carModelAnalysisResponses = [];
      for (var v in value.data) {
        carModelAnalysisResponses.add(CarModelAnalysisResponse.fromJson(v));
      }
      emit(GetCarModelAnalysisSuccessState(carModelAnalysisResponses));
    }).onError((error, stackTrace) {
      emit(GetCarModelAnalysisErrorState());
    });
  }

  Future getRoadAnalysis() async {
    String url = "/admin/roadsAnalytics/";
    emit(GetRoadAnalysisLoadingState());
    DioHelper.getData(
      url: url,
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      List<RoadAnalysisResponse> roadAnalysisResponses = [];
      for (var v in value.data) {
        roadAnalysisResponses.add(RoadAnalysisResponse.fromJson(v));
      }
      emit(GetRoadAnalysisSuccessState(roadAnalysisResponses));
    }).onError((error, stackTrace) {
      emit(GetRoadAnalysisErrorState());
    });
  }
}

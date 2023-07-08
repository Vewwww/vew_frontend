import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:vewww/model/car_mosel_analysis_response.dart';

import '../../core/utils/sp_helper/cache_helper.dart';
import '../../model/analysis.dart';
import '../../services/dio_helper.dart';

part 'admin_analysis_state.dart';

class AdminAnalysisCubit extends Cubit<AdminAnalysisState> {
  AdminAnalysisCubit() : super(AdminAnalysisInitial());
  static AdminAnalysisCubit get(context) => BlocProvider.of(context);
  Future getUserAnalysis() async {
    String url = "/admin/userStatistics/";
    emit(GetUserAnalysisLoadingState());
    DioHelper.getData(
      url: url,
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      print("Get users analysis response : ${value.data}");
      UserAnalysisResponse userAnalysisResponse =
          UserAnalysisResponse.fromJson(value.data);
      emit(GetUserAnalysisSuccessState(userAnalysisResponse));
    }).onError((error, stackTrace) {
      print("Get users analysis error : $error");
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
      print("Get gender analysis response : ${value.data}");
      GenderAnalysisResponse genderAnalysisResponse =
          GenderAnalysisResponse.fromJson(value.data);
      emit(GetGenderrAnalysisSuccessState(genderAnalysisResponse));
    }).catchError((error, stackTrace) {
      if (error is DioError)
        print("Get gender analysis error : ${error.response}");
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
      print("Get season analysis response : ${value.data}");
      SeasonAnalysisResponse seasonAnalysisResponse =
          SeasonAnalysisResponse.fromJson(value.data);
      emit(GetSeasonAnalysisSuccessState(seasonAnalysisResponse));
    }).onError((error, stackTrace) {
      print("Get season analysis error : $error");
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
      print("Get season analysis response : ${value.data}");
      List<CarModelAnalysisResponse> carModelAnalysisResponses = [];
      for (var v in value.data) {
        carModelAnalysisResponses.add(CarModelAnalysisResponse.fromJson(v));
      }
      emit(GetCarModelAnalysisSuccessState(carModelAnalysisResponses));
    }).onError((error, stackTrace) {
      print("Get season analysis error : $error");
      emit(GetCarModelAnalysisErrorState());
    });
  }
}

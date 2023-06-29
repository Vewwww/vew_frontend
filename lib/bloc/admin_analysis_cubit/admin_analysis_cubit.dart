import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

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
      token:SharedPreferencesHelper.getData(key: 'vewToken'),
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
      token:SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      print("Get gender analysis response : ${value.data}");
      GenderAnalysisResponse genderAnalysisResponse =
          GenderAnalysisResponse.fromJson(value.data);
      emit(GetGenderrAnalysisSuccessState(genderAnalysisResponse));
    }).onError((error, stackTrace) {
      print("Get gender analysis error : $error");
      emit(GetGenderAnalysisErrorState());
    });
  }

}

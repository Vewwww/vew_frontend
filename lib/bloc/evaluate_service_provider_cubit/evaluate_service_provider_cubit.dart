import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/sp_helper/cache_helper.dart';
import '../../services/dio_helper.dart';
part 'evaluate_service_provider_state.dart';

class EvaluateServiceProviderCubit extends Cubit<EvaluateServiceProviderState> {
  EvaluateServiceProviderCubit() : super(EvaluateServiceProviderInitial());
  static EvaluateServiceProviderCubit get(context) => BlocProvider.of(context);

  Future<void> reportWinch(String id) async {
    emit(ReportWinchLoadingState());
    await DioHelper.patchData(
      url: "/driver/winch/report/${id}",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
      data: {},
    ).then((value) {
      print("Winch report response: ${value.data}");
      emit(ReportWinchSuccessState());
    }).onError((error, stackTrace) {
      print("Winch report : ${error}");
      emit(ReportWinchErrorState());
    });
  }

  Future<void> reportMechanic(String id) async {
    emit(ReportMechanicLoadingState());
    await DioHelper.patchData(
      url: "/driver/mechanic/report/${id}",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
      data: {},
    ).then((value) {
      print("Mechanic report : ${value.data}");
      emit(ReportMechanicSuccessState());
    }).onError((error, stackTrace) {
      print("Mechanic report : ${error}");
      emit(ReportMechanicErrorState());
    });
  }

  Future<void> rateMechanic(String id, double rate) async {
    emit(RateMechanicLoadingState());
    await DioHelper.patchData(
      url: "/driver/mechanic/rate/${id}",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
      data: {"rating": rate},
    ).then((value) {
      print("raiting mechanic response ${value.data}");
      emit(RateMechanicSuccessState());
    }).onError((error, stackTrace) {
      print("Mechanic rate : ${error}");
      emit(RateMechanicErrorState());
    });
  }

  Future<void> rateWinch(String id, double rate) async {
    emit(RateWinchLoadingState());
    await DioHelper.patchData(
      url: "/driver/winch/rate/${id}",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
      data: {"rating": rate},
    ).then((value) {
      print("raiting winch response ${value.data}");
      emit(RateWinchSuccessState());
    }).onError((error, stackTrace) {
      print("Winch rate : ${error}");
      emit(RateWinchErrorState());
    });
  }
}

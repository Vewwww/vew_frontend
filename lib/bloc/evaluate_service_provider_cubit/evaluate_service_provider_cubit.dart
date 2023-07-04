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
      data:{},
    ).then((value) {
      emit(ReportWinchSuccessState());
    }).onError((error, stackTrace) {
      emit(ReportWinchErrorState());
      print("Winch report : ${error}");
    });
  }

  Future<void> reportMechanic(String id) async {
    emit(ReportMechanicLoadingState());
    await DioHelper.patchData(
      url: "/driver/mechanic/report/${id}",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
      data:{},
    ).then((value) {
      emit(ReportMechanicSuccessState());
    }).onError((error, stackTrace) {
      emit(ReportMechanicErrorState());
      print("Mechanic report : ${error}");
    });
  }

  Future<void> rateMechanic(String id, double rate) async {
    emit(RateMechanicLoadingState());
    await DioHelper.patchData(
      url: "/driver/mechanic/rate/${id}",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
      data:{"rating":rate},
    ).then((value) {
      emit(RateMechanicSuccessState());
    }).onError((error, stackTrace) {
      emit(RateMechanicErrorState());
      print("Mechanic rate : ${error}");
    });
  }

  Future<void> rateWinch(String id, double rate) async {
    emit(RateWinchLoadingState());
    await DioHelper.patchData(
      url: "/driver/winch/rate/${id}",
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
      data:{"rating":rate},
    ).then((value) {
      emit(RateWinchSuccessState());
    }).onError((error, stackTrace) {
      emit(RateWinchErrorState());
      print("Winch report : ${error}");
    });
  }
}

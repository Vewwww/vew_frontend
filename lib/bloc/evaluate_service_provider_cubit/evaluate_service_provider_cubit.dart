import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../services/dio_helper.dart';

part 'evaluate_service_provider_state.dart';

class EvaluateServiceProviderCubit extends Cubit<EvaluateServiceProviderState> {
  EvaluateServiceProviderCubit() : super(EvaluateServiceProviderInitial());
  static EvaluateServiceProviderCubit get(context) => BlocProvider.of(context);

   Future<void> reportWinch(String id) async {
    emit(ReportWinchLoadingState());
    await DioHelper.getData(url: "/driver/winch/report/:${id}").then((value) {
      print("get all warning sign response : ${value.data}");
      //sign = Sign.fromJson(value.data["data"]);
      //print("get all warning sign names : ${sign!.name!.en}");
      emit(ReportWinchSuccessState());
    }).onError((error, stackTrace) {
      emit(ReportWinchErrorState());
      print("gat all warning sign error : ${error}");
    });
  }
}

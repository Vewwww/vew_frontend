import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../model/car_type.dart';
import '../../services/dio_helper.dart';

part 'select_choice_state.dart';

class SelectChoiceCubit extends Cubit<SelectChoiceState> {
  SelectChoiceCubit() : super(SelectChoiceInitial());
  static SelectChoiceCubit get(context) => BlocProvider.of(context);
  int choice = 0;
  CarTypeResponse? carTypeResponse;

  void chose(int c) {
    choice = c;
    emit(ChoiceSelected());
  }

  Future<void> getAllCarTypes() async {
    emit(GetAllCarTypesLoadingState());
    await DioHelper.getData(url: "/cartype/").then((value) {
      //print("get all car types response : ${value.data}");
      carTypeResponse = CarTypeResponse.fromJson(value.data);
      //print("get all car types : ${carTypeResponse!.carType}");
      emit(GetAllCarTypesSuccessState());
    }).onError((error, stackTrace) {
      emit(GetAllCarTypesErrorState());
      print("gat all car types error : $error");
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../model/car_model.dart';
import '../../model/car_type.dart';
import '../../services/dio_helper.dart';

part 'select_choice_state.dart';

class SelectChoiceCubit extends Cubit<SelectChoiceState> {
  SelectChoiceCubit() : super(SelectChoiceInitial());
  static SelectChoiceCubit get(context) => BlocProvider.of(context);
  int carTypeChoice = 0;
  int carModelChoice = 0;
  bool hasDelivery = false;
  CarTypeResponse? carTypeResponse;
  CarModelResponse? carModelResponse;

  void choseCarType(int c) {
    carTypeChoice = c;
    emit(CarTypeChoiceSelected());
  }

  void changeHasDelivey() {
    hasDelivery = !hasDelivery;
    emit(HasDeliveryChangedState());
  }

  void choseCarModel(int c) {
    carModelChoice = c;
    emit(CarModelChoiceSelected());
  }

  Future<void> getAllCarTypes() async {
    carTypeChoice = 0;
    emit(GetAllCarTypesLoadingState());
    await DioHelper.getData(url: "/carType").then((value) {
      print("get all car types response : ${value.data}");
      carTypeResponse = CarTypeResponse.fromJson(value.data);
      //print("get all car types : ${carTypeResponse!.carType}");
      emit(GetAllCarTypesSuccessState());
    }).onError((error, stackTrace) {
      emit(GetAllCarTypesErrorState());
      print("gat all car types error : $error");
    });
  }

  Future<void> getAllCarModels(String id) async {
    carModelChoice = 0;

    emit(GetAllCarModelsLoadingState());
    await DioHelper.getData(url: "/carModel/$id/").then((value) {
      print("get all car models response : ${value.data}");
      carModelResponse = CarModelResponse.fromJson(value.data);
      //print("get all car types : ${carTypeResponse!.carType}");
      emit(GetAllCarModelsSuccessState());
    }).onError((error, stackTrace) {
      emit(GetAllCarModelsErrorState());
      print("gat all car models error : $error");
    });
  }
}

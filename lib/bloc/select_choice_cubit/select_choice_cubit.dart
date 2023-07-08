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

  //controls mechanic have delivey field 
  //in signup and edit profile
  void changeHasDelivey() {
    hasDelivery = !hasDelivery;
    emit(HasDeliveryChangedState());
  }

  void choseCarType(int c) {
    carTypeChoice = c;
    emit(CarTypeChoiceSelected());
  }

  void choseCarModel(int c) {
    carModelChoice = c;
    emit(CarModelChoiceSelected());
  }

  Future<void> getAllCarTypes() async {
    carTypeChoice = 0;
    emit(GetAllCarTypesLoadingState());
    await DioHelper.getData(url: "/carType").then((value) {
      carTypeResponse = CarTypeResponse.fromJson(value.data);
      emit(GetAllCarTypesSuccessState());
    }).onError((error, stackTrace) {
      emit(GetAllCarTypesErrorState());
    });
  }

  Future<void> getAllCarModels(String id) async {
    carModelChoice = 0;
    emit(GetAllCarModelsLoadingState());
    await DioHelper.getData(url: "/carModel/$id/").then((value) {
      carModelResponse = CarModelResponse.fromJson(value.data);
      emit(GetAllCarModelsSuccessState());
    }).onError((error, stackTrace) {
      emit(GetAllCarModelsErrorState());
    });
  }
}

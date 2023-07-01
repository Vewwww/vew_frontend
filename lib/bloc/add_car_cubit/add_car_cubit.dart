import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../model/car.dart';
import '../../services/dio_helper.dart';

part 'add_car_state.dart';

class AddCarCubit extends Cubit<AddCarState> {
  AddCarCubit() : super(AddCarInitial());
  static AddCarCubit get(context) => BlocProvider.of(context);

  //bool carExist = false;
  List<Car> cars = [];

  void add(Car car) {
    //carExist = true;
    cars.add(car);
    emit(CarAddedState());
  }

  bool checkCarExists(Car comingCar) {
    for (Car car in cars) {
      if (car.sId == comingCar.sId) return true;
    }
    return false;
  }

  bool isEdited(Car comingCar) {
    if (checkCarExists(comingCar)) {
      bool contains = cars.contains(comingCar);
      if (!contains) {
        return true;
      }
    }
    return false;
  }

  void remove(index) {
    //carExist = false;
    cars.removeAt(index);
    emit(CarRemovedState());
  }
}

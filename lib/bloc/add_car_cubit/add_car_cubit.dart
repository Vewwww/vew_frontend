import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../model/car.dart';

part 'add_car_state.dart';

//Cubit to make add car responsive ui in driver sign up screen
class AddCarCubit extends Cubit<AddCarState> {
  AddCarCubit() : super(AddCarInitial());
  static AddCarCubit get(context) => BlocProvider.of(context);
  List<Car> cars = [];

  void add(Car car) {
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
    cars.removeAt(index);
    emit(CarRemovedState());
  }
}

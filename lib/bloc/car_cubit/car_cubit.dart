import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/core/utils/sp_helper/cache_helper.dart';
import '../../model/car.dart';
import '../../services/dio_helper.dart';

part 'car_state.dart';

class CarCubit extends Cubit<CarState> {
  CarCubit() : super(CarInitial());
  List<Car>? currentCars;
  List<Car>? editedCars;
  static CarCubit get(context) => BlocProvider.of(context);

  Future<void> createCar(Car car) async {
    emit(CreateCarLoadingState());
    await DioHelper.postData(url: "/car/", data: car.toJson()).then((value) {
      print("create car response : ${value}");
      emit(CreateCarSuccessState());
    }).onError((error, stackTrace) {
      print("Create car error : $error");
      emit(CreateCarErrorState());
    });
  }

  Future<void> addCar(Car car) async {
    print("adding car");
    emit(AddCarLoadingState());
    await DioHelper.postData(
            url: "/driver/car/",
            data: car.toJson(),
            token: SharedPreferencesHelper.getData(key: "vewToken"))
        .then((value) {
      print("add car response : ${value}");
      emit(AddCarSuccessState());
    }).onError((error, stackTrace) {
      print("add car error : $error");
      emit(AddCarErrorState());
    });
  }

  Future<void> updateCar(Car car) async {
    print("updatingg car");
    emit(UpdateCarLoadingState());
    await DioHelper.putData(
            url: "/car/${car.sId}",
            data: car.toJson(),
            token: SharedPreferencesHelper.getData(key: "vewToken"))
        .then((value) {
      print("update car response : ${value}");
      emit(UpdateCarSuccessState());
    }).catchError((
      error,
    ) {
      if (error is DioError) print("update car error : ${error.response}");
      emit(UpdateCarErrorState());
    });
  }

  Future<void> removeCar(Car car) async {
    print("removing car");
    emit(RemoveCarLoadingState());
    await DioHelper.deleteData(
            url: "/car/${car.sId}",
            data: car.toJson(),
            token: SharedPreferencesHelper.getData(key: "vewToken"))
        .then((value) {
      print("remove car response : ${value}");
      emit(RemoveCarSuccessState());
    }).onError((error, stackTrace) {
      print("remove car error : $error");
      emit(RemoveCarErrorState());
    });
  }

  bool carExistInCurrent(Car commingCar) {
    if (currentCars != null) {
      for (Car car in currentCars!) {
        if (car.sId == commingCar.sId) return true;
      }
    }
    return false;
  }

  bool carExistInEdited(Car commingCar) {
    if (editedCars != null) {
      for (Car car in editedCars!) {
        if (car.sId == commingCar.sId) return true;
      }
    }
    return false;
  }

  Future<void> handleCarEdit() async {
    bool exists;
    if (editedCars != null && currentCars != null) {
      for (Car car in currentCars!) {
        exists = carExistInEdited(car);
        if (!exists) {
          await removeCar(car);
        }
      }
      for (Car car in editedCars!) {
        exists = carExistInCurrent(car);
        if (exists) {
          await updateCar(car);
        } else {
          await addCar(car);
        }
      }
    }
    if (state is! UpdateCarErrorState &&
        state is! AddCarErrorState &&
        state is! RemoveCarErrorState)
      emit(CarHandeledState());
    else
      emit(CarHandeleErrorState());
  }

  void remove(Car commingCar) {
    int index = 0;
    if (editedCars != null && carExistInEdited(commingCar)) {
      for (Car car in editedCars!) {
        if (car.sId == commingCar.sId) break;
        index++;
      }
      editedCars!.removeAt(index);
      emit(CarRemoved());
    }
  }

  void add() {
    if (editedCars != null) {
      Car car = Car();
      editedCars!.add(car);
      emit(CarRemoved());
    }
  }
}

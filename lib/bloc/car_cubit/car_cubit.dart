import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/core/utils/sp_helper/cache_helper.dart';
import '../../model/car.dart';
import '../../services/dio_helper.dart';
part 'car_state.dart';

class CarCubit extends Cubit<CarState> {
  CarCubit() : super(CarInitial());
  List<Car>? driverCars;
  List<Car>? updatedCars;
  static CarCubit get(context) => BlocProvider.of(context);

  Future<void> createCar(Car car) async {
    emit(CreateCarLoadingState());
    await DioHelper.postData(url: "/car/", data: car.toJson()).then((value) {
      emit(CreateCarSuccessState());
    }).onError((error, stackTrace) {
      emit(CreateCarErrorState());
    });
  }

  Future<void> addCar(Car car) async {
    emit(AddCarLoadingState());
    await DioHelper.postData(
            url: "/driver/car",
            data: car.upadateToJson(),
            token: SharedPreferencesHelper.getData(key: "vewToken"))
        .then((value) {
      if (driverCars != null) {
        driverCars!.add(car);
      } else {
        driverCars = [car];
      }
      emit(AddCarSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        emit(AddCarErrorState());
      }
    });
  }

  Future<void> updateCar(Car car) async {

    emit(UpdateCarLoadingState());
    await DioHelper.putData(
            url: "/driver/car/${car.sId}",
            data: car.upadateToJson(),
            token: SharedPreferencesHelper.getData(key: "vewToken"))
        .then((value) {
      emit(UpdateCarSuccessState());
    }).catchError((
      error,
    ) {
      if (error is DioError) {
        emit(UpdateCarErrorState());
      }
    });
  }

  Future<void> removeCar(Car car) async {
    emit(RemoveCarLoadingState());
    await DioHelper.deleteData(
            url: "/driver/car/${car.sId}",
            token: SharedPreferencesHelper.getData(key: "vewToken"))
        .then((value) {
      emit(RemoveCarSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        emit(RemoveCarErrorState());
      }
    });
  }

  bool carExistInCurrent(Car commingCar) {
    if (driverCars != null) {
      for (Car driverCar in driverCars!) {
        if (driverCar.sId == commingCar.sId) return true;
      }
    }
    return false;
  }

  bool carExistInEdited(Car commingCar) {
    if (updatedCars != null) {
      for (Car updatedCar in updatedCars!) {
        if (updatedCar.sId == commingCar.sId) {
          return true;
        }
      }
    }
    return false;
  }


  Future<void> handleCarEdit() async {
    bool exists;
    if (updatedCars != null && driverCars != null) {
      for (Car car in driverCars!) {
        exists = carExistInEdited(car);
        if (!exists) {
          await removeCar(car);
        }
      }
      for (Car car in updatedCars!) {
        exists = carExistInCurrent(car);
        if (exists) {
          await updateCar(car);
        } 
      }
    }
    if (state is! UpdateCarErrorState &&
        state is! AddCarErrorState &&
        state is! RemoveCarErrorState) {
      emit(CarHandeledState());
    } else {
      emit(CarHandeleErrorState());
    }
  }

  void remove(Car commingCar) {
    int index = 0;
    if (updatedCars != null && carExistInEdited(commingCar)) {
      for (Car car in updatedCars!) {
        if (car.sId == commingCar.sId) break;
        index++;
      }
      updatedCars!.removeAt(index);
      emit(CarRemoved());
    }
  }

  Future<void> add(Car car ) async{
    if (updatedCars != null) {
      updatedCars!.add(car);
      emit(CarAdded());
    } else {
      updatedCars = [];
      updatedCars!.add(Car());
    }
    await addCar(car);
  }


  Future getAllDriverCars(String id) async {
    String url = "/driver/car/carOwner/${id}";
    emit(GetAllDriverCarsLoadingState());
    await DioHelper.getData(
      url: url,
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      List<Car> allCars = [];
      for (var x in value.data) {
        allCars.add(Car.fromJson(x));
      }
      emit(GetAllDriverCarsSuccessState(allCars));
    }).onError((error, stackTrace) {
      emit(GetAllDriverCarsErrorState());
    });
  }
}

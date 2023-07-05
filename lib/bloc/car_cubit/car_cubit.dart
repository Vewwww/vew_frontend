import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/core/utils/sp_helper/cache_helper.dart';
import 'package:vewww/model/all_car.dart';
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
      print("create car response : ${value}");
      emit(CreateCarSuccessState());
    }).onError((error, stackTrace) {
      print("Create car error : $error");
      emit(CreateCarErrorState());
    });
  }

  Future<void> addCar(Car car) async {
    print("adding car : ${car.upadateToJson()}");
    emit(AddCarLoadingState());
    await DioHelper.postData(
            url: "/driver/car",
            data: car.upadateToJson(),
            token: SharedPreferencesHelper.getData(key: "vewToken"))
        .then((value) {
      print("add car response : ${value}");
      emit(AddCarSuccessState());
    }).catchError((error) {
      if (error is DioError) print("add car error : ${error.response}");
      emit(AddCarErrorState());
    });
  }

  Future<void> updateCar(Car car) async {
    print("updatingg car : ${car.upadateToJson()}");

    emit(UpdateCarLoadingState());
    await DioHelper.putData(
            url: "/driver/car/${car.sId}",
            data: car.upadateToJson(),
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
    print("removing car ${car.sId} , ");
    emit(RemoveCarLoadingState());
    await DioHelper.deleteData(
            url: "/driver/car/${car.sId}",
            //data: car.toJson(),
            token: SharedPreferencesHelper.getData(key: "vewToken"))
        .then((value) {
      print("remove car response : ${value}");
      emit(RemoveCarSuccessState());
    }).catchError((error) {
      if (error is DioError) print("remove car error : ${error}");
      emit(RemoveCarErrorState());
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

  void testcars() {
    print("current cars :");
    if (driverCars != null)
      for (Car c in driverCars!) print(c.toJson());
    else
      print("curent cars null");
    print("edit cars :");
    if (updatedCars != null)
      for (Car ca in updatedCars!) print(ca.toJson());
    else
      print("edits cars null");
  }

  Future<void> handleCarEdit() async {
    bool exists;
    testcars();
    if (updatedCars != null && driverCars != null) {
      for (Car car in driverCars!) {
        exists = carExistInEdited(car);
        if (!exists) {
          print("will remove");
          await removeCar(car);
        }
      }
      for (Car car in updatedCars!) {
        exists = carExistInCurrent(car);
        if (exists) {
          print("will update");
          await updateCar(car);
        } else {
          print("will add");
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
    if (updatedCars != null && carExistInEdited(commingCar)) {
      for (Car car in updatedCars!) {
        if (car.sId == commingCar.sId) break;
        index++;
      }
      updatedCars!.removeAt(index);
      emit(CarRemoved());
    }
  }

  void add(String id) {
    if (updatedCars != null) {
      Car car = Car(owner: id);
      print("test before from add:");
      testcars();
      updatedCars!.add(car);
      print("test from add:");
      testcars();
      emit(CarAdded());
    } else {
      updatedCars = [];
      updatedCars!.add(Car());
    }
  }

  Future getAllDriverCars(String id) async {
    String url = "/driver/car/carOwner/${id}";
    print(url);
    emit(GetAllDriverCarsLoadingState());
    await DioHelper.getData(
      url: url,
      token: SharedPreferencesHelper.getData(key: 'vewToken'),
    ).then((value) {
      print("Get Driver Cars response : ${value.data}");
      //AllCarsResponse allCarsResponse = AllCarsResponse.fromJson(value.data);
      List<Car> allCars = [];
      for (var x in value.data) allCars.add(Car.fromJson(x));
      emit(GetAllDriverCarsSuccessState(allCars));
    }).onError((error, stackTrace) {
      print("Get Driver Cars error : $error");
      emit(GetAllDriverCarsErrorState());
    });
  }
}

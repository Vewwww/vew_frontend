import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/car.dart';
import '../../services/dio_helper.dart';

part 'car_state.dart';

class CarCubit extends Cubit<CarState> {
  CarCubit() : super(CarInitial());
  static CarCubit get(context) => BlocProvider.of(context);
  void createCar(Car car) async {
    print("driver signup request : ${car.toJson()}");
    emit(CreateCarLoadingState());
    await DioHelper.postData(url: "/car/", data: car.toJson())
        .then((value) {
      print("create car response : ${value}");
      emit(CreateCarSuccessState());
    }).onError((error, stackTrace) {
      print("Create car error : $error");
      emit(CreateCarErrorState());
    });
  }
}

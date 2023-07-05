part of 'car_cubit.dart';

abstract class CarState {}

class CarInitial extends CarState {}
class CreateCarLoadingState extends CarState {}
class CreateCarSuccessState extends CarState {}
class CreateCarErrorState extends CarState {}
class UpdateCarLoadingState extends CarState {}
class UpdateCarSuccessState extends CarState {}
class UpdateCarErrorState extends CarState {}
class RemoveCarLoadingState extends CarState {}
class RemoveCarSuccessState extends CarState {}
class RemoveCarErrorState extends CarState {}
class AddCarLoadingState extends CarState {}
class AddCarSuccessState extends CarState {}
class AddCarErrorState extends CarState {}
class CarHandeledState extends CarState {}
class CarHandeleErrorState extends CarState {}
class CarRemoved extends CarState {}
class CarAdded extends CarState {}

class GetAllDriverCarsLoadingState extends CarState {}
class GetAllDriverCarsSuccessState extends CarState {
  final List<Car> allCars;
  GetAllDriverCarsSuccessState(this.allCars);
}
class GetAllDriverCarsErrorState extends CarState {}
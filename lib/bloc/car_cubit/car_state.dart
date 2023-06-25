part of 'car_cubit.dart';

abstract class CarState {}

class CarInitial extends CarState {}
class CreateCarLoadingState extends CarState {}
class CreateCarSuccessState extends CarState {}
class CreateCarErrorState extends CarState {}
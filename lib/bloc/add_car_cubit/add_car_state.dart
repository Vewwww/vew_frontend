part of 'add_car_cubit.dart';

@immutable
abstract class AddCarState {}

class AddCarInitial extends AddCarState {}
class CarAddedState extends AddCarState {}
class CarRemovedState extends AddCarState {}

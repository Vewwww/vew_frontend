import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'add_car_state.dart';

class AddCarCubit extends Cubit<AddCarState> {
  AddCarCubit() : super(AddCarInitial());
  static AddCarCubit get(context) => BlocProvider.of(context);

  bool carExist = false;

  void add() {
    carExist = true;
    emit(CarAddedState());
  }

  void remove() {
    carExist = false;
    emit(CarRemovedState());
  }
}

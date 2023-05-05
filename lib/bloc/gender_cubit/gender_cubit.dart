import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'gender_state.dart';

class GenderCubit extends Cubit<GenderState> {
  GenderCubit() : super(GenderInitial());
  static GenderCubit get(context) => BlocProvider.of(context);
  int gender = 1;
  void choseGender(int c) {
    gender = c;
    print("gender : $gender");
    emit(GenderSelected());
  }
}

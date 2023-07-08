import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'gender_state.dart';

class GenderCubit extends Cubit<GenderState> {
  GenderCubit() : super(GenderInitial());
  static GenderCubit get(context) => BlocProvider.of(context);
  int gender = 1;
  String genderInText = "male";

  //select gender for responsive ai in sign up and edit profile
  void choseGender(int c) {
    gender = c;
    genderInText = (gender==1 )? "male":"female";
    emit(GenderSelected());
  }
}
